######################################################################
# LAMBDA DB 
######################################################################

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