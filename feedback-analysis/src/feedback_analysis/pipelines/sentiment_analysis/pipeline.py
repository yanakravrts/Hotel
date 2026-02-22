from kedro.pipeline import Pipeline, node, pipeline
from .nodes import analyze_sentiment, update_table

def create_pipeline(**kwargs) -> Pipeline:
    return pipeline([
        node(
            func=analyze_sentiment,
            inputs=["pending_feedback", "params:gemini_api_key"],
            outputs="processed_feedback", 
            name="sentiment_analysis_node",
        ),
        node(
            func=update_table,
            inputs=["processed_feedback", "params:postgres_db"], 
            outputs=None,
            name="update_database_node",
        ),
    ])