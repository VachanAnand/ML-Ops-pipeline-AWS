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

resource "aws_s3_bucket" "s3_datalake" {
    bucket = var.s3_datalake_name
    tags = {
        environment = var.environment
        creator = var.creator
        type = var.type
    }
}
resource "aws_s3_bucket_notification" "s3_notification" {
    bucket = aws_s3_bucket.s3_ml_pipeline.id
    depends_on = [
        aws_sns_topic.sns_topic,
        aws_sns_topic_policy.sns_topic_policy
    ]
    topic {
        topic_arn = aws_sns_topic.sns_topic.arn
        events = ["s3:ObjectCreated:*"]
    }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.s3_amplify_bucket_name
  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda_landing.arn
    events = ["s3:ObjectCreated:*"]
  }
  depends_on = [aws_lambda_permission.allow_bucket]
}