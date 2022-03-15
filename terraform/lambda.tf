data "archive_file" "lambda_zip"{
    type = "zip"
    source_file = "${path.module}/../lambda/landing/main.py" 
    output_path = "${path.module}/../lambda/landing/main.zip"
}

######################################################################
# LAMBDA FUNCTIONS 
######################################################################

resource "aws_lambda_function" "lambda" {
    function_name = var.lambda_name
    filename = "${path.module}/../lambda/landing/main.zip"
    role = aws_iam_role.iam_lambda.arn
    handler = "main.lambda_handler"
    runtime = "python3.8"
    tags = {
        environment = var.environment
        creator = var.creator
        type = var.type
    }
}

resource "aws_lambda_event_source_mapping" "lambda_event_mapping" {
  event_source_arn = aws_sqs_queue.sqs_db.arn
  function_name = aws_lambda_function.lambda.arn
}