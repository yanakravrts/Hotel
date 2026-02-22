"""Project pipelines."""
from typing import Dict
from kedro.pipeline import Pipeline
from feedback_analysis.pipelines import sentiment_analysis as sa

def register_pipelines() -> Dict[str, Pipeline]:
    sentiment_pipeline = sa.create_pipeline()
    return {
        "sa": sentiment_pipeline,
        "__default__": sentiment_pipeline,
    }
