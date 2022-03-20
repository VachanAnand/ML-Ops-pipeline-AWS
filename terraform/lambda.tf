######################################################################
# LAMBDA DB 
######################################################################




resource "aws_lambda_function" "lambda_landing" {
    function_name = var.lambda_landing_name
    image_uri = "464866296249.dkr.ecr.ap-southeast-2.amazonaws.com/demo/load-amplify:test"
    package_type = "Image"
    role = aws_iam_role.iam_lambda.arn
    tags = {
        environment = var.environment
        creator = var.creator
        type = var.type
        version = "v4"
    }
}


resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_landing.arn
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${var.s3_amplify_bucket_name}"
}




resource "aws_lambda_function" "lambda_db" {
    function_name = var.lambda_db_name
    image_uri = "464866296249.dkr.ecr.ap-southeast-2.amazonaws.com/demo/database:test"
    package_type = "Image"
    role = aws_iam_role.iam_lambda.arn
    tags = {
        environment = var.environment
        creator = var.creator
        type = var.type
        version = "v3"
    }
}

resource "aws_lambda_event_source_mapping" "lambda_db_event_mapping" {
  event_source_arn = aws_sqs_queue.sqs_db.arn
  function_name = aws_lambda_function.lambda_db.arn
}

######################################################################
# LAMBDA DL (DATA LAKE)
######################################################################

resource "aws_lambda_function" "lambda_dl" {
    function_name = var.lambda_dl_name
    image_uri = "464866296249.dkr.ecr.ap-southeast-2.amazonaws.com/demo/datalake:test"
    package_type = "Image"
    role = aws_iam_role.iam_lambda.arn
    tags = {
        environment = var.environment
        creator = var.creator
        type = var.type
        version = "v1"
    }
}

resource "aws_lambda_event_source_mapping" "lambda_dl_event_mapping" {
  event_source_arn = aws_sqs_queue.sqs_dl.arn
  function_name = aws_lambda_function.lambda_dl.arn
}