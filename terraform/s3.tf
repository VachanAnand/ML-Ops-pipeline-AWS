######################################################################
# S3 
######################################################################

resource "aws_s3_bucket" "s3_ml_pipeline" {
    bucket = var.s3_bucket_name
    tags = {
        environment = var.environment
        creator = var.creator
        type = var.type
    }
}

resource "aws_s3_bucket_notification" "s3_landing_notification" {
    bucket = aws_s3_bucket.s3_ml_pipeline.id
    topic {
        topic_arn = aws_sns_topic.sns_landing_topic.arn
        events = ["s3:ObjectCreated:*"]
    }
}