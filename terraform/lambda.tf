data "archive_file" "lambda_db"{
    type = "zip"
    source_file = "${path.module}/../lambda/db/main.py" 
    output_path = "${path.module}/../lambda/db/main.zip"
}

data "archive_file" "lambda_zip"{
    type = "zip"
    source_file = "${path.module}/../lambda/zip/main.py" 
    output_path = "${path.module}/../lambda/zip/main.zip"
}

######################################################################
# LAMBDA DB 
######################################################################

resource "aws_lambda_function" "lambda_db" {
    function_name = var.lambda_db_name
    filename = "${path.module}/../lambda/db/main.zip"
    role = aws_iam_role.iam_lambda.arn
    handler = "main.lambda_handler"
    runtime = "python3.8"
    tags = {
        environment = var.environment
        creator = var.creator
        type = var.type
    }
}

resource "aws_lambda_event_source_mapping" "lambda_db_event_mapping" {
  event_source_arn = aws_sqs_queue.sqs_db.arn
  function_name = aws_lambda_function.lambda_db.arn
}

######################################################################
# LAMBDA ZIP 
######################################################################

resource "aws_lambda_function" "lambda_zip" {
    function_name = var.lambda_zip_name
    filename = "${path.module}/../lambda/zip/main.zip"
    role = aws_iam_role.iam_lambda.arn
    handler = "main.lambda_handler"
    runtime = "python3.8"
    tags = {
        environment = var.environment
        creator = var.creator
        type = var.type
    }
}

resource "aws_lambda_event_source_mapping" "lambda_zip_event_mapping" {
  event_source_arn = aws_sqs_queue.sqs_db.arn
  function_name = aws_lambda_function.lambda_zip.arn
}