import pandas as pd
from google import genai
import logging
import time
from datetime import datetime
from sqlalchemy import create_engine, text

logger = logging.getLogger(__name__)

def analyze_sentiment(data: pd.DataFrame, api_key: str) -> pd.DataFrame:
    if data.empty:
        logger.info("No pending feedback to analyze")
        return data
    
    client = genai.Client(api_key=api_key)
    processed_rows = []

    few_shot_examples = """
    Example 1:
    Review: 'The boat was amazing and the staff was very helpful.'
    Sentiment: Positive

    Example 2:
    Review: 'The engine was too loud and the seats were dirty.'
    Sentiment: Negative

    Example 3:
    Review: 'It was an average trip, nothing special.'
    Sentiment: Neutral
    """

    for index, row in data.iterrows():
        try:
            logger.info(f"Processing review: {index+1}/{len(data)}")
            prompt = f"""
            Task: Analyze the sentiment of the following boat rental review.
            {few_shot_examples}
            
            Current Review: '{row['review_text']}'
            Sentiment: 
            """

            response = client.models.generate_content(
                model="gemini-2.5-flash",
                contents=prompt
            )
            sentiment = response.text.strip()

            if sentiment not in ['Positive', 'Negative', 'Neutral']:
                logger.warning(f"Unexpected sentiment format: {sentiment}. Defaulting to Neutral.")
                sentiment = 'Neutral'

            row['sentimental_label'] = sentiment
            row['processing_status'] = 'processed'
            row['processed_at'] = datetime.now()
            
            processed_rows.append(row)

            if index < len(data) - 1:
                logger.info("Waiting 30 seconds to respect API quota...")
                time.sleep(30)

        except Exception as e:
            logger.error(f"Error at review {index}: {e}")
            row['processing_status'] = 'failed'
            processed_rows.append(row)
            
    return pd.DataFrame(processed_rows)

def update_table(processed_data, credentials):
    engine = create_engine(credentials['con'])
    with engine.connect() as conn:
        conn.execute(text("""
            UPDATE feedback f
            SET 
                sentimental_label = u.sentimental_label,
                processing_status = u.processing_status,
                processed_at = u.processed_at
            FROM feedback_updates u
            WHERE f.feedback_id = u.feedback_id;
        """))
        conn.execute(text("DROP TABLE feedback_updates;"))
        conn.commit()
    return None