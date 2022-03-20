######################################################################
# TAGS 
######################################################################

variable environment {
  type        = string
  default     = "dev"
}

variable creator {
  type        = string
  default     = "vachan"
}

variable type {
  type        = string
  default     = "ml-pipeline"
}

######################################################################
# demo VARIABLES
######################################################################

variable s3_bucket_name {
  type        = string
  default     = "ml-pipeline"
  description = "S3 bucket name for machine learning pipeline demo"
}

variable s3_amplify_bucket_name {
  type        = string
  default     = "ml-pipeline"
  description = "S3 bucket name for machine learning pipeline demo"
}

variable s3_datalake_name {
  type        = string
  default     = "dl"
  description = "S3 bucket name for machine learning pipeline demo"
}

variable sns_name {
  type        = string
  default     = "sns-demo"
  description = "Name of SNS used when data lands in s3"
}

variable sqs_db_name {
  type        = string
  default     = "sqs-demo"
  description = "Name of SQS used when data lands in s3"
}

variable sqs_db_dlq_name {
  type        = string
  default     = "sqs-dlq-demo"
  description = "Name of SQS dead letter queue used when data lands in s3"
}

variable sqs_dl_name {
  type        = string
  default     = "sqs-demo"
  description = "Name of SQS used when data lands in s3"
}

variable sqs_dl_dlq_name {
  type        = string
  default     = "sqs-dlq-demo"
  description = "Name of SQS dead letter queue used when data lands in s3"
}

variable lambda_dl_name {
  type        = string
  default     = "lambda-demo"
}

variable lambda_db_name {
  type        = string
  default     = "lambda-demo"
}

variable lambda_landing_name{
  type        = string
  default     = "lambda-demo"
}

variable iam_lambda_name {
  type        = string
  default     = "iam-lambda-demo"
}

variable iam_policy_lambda_name {
  type        = string
  default     = "iam-policy-lambda-demo"
}

variable iam_policy_lambda_logs_name {
  type        = string
  default     = "iam-policy-lambda-demo-logs"
}

variable iam_policy_lambda_dynamodb_name {
  type        = string
  default     = "iam-policy-lambda-demo-logs"
}

variable dynamodb_name {
  type        = string
  default     = "dynamodb-demo"
}

variable ecr_db_name {
  type        = string
  default     = "demo/db"
}

variable ecr_dl_name {
  type        = string
  default     = "demo/dl"
}

variable ecr_amplify_name {
  type        = string
  default     = "demo/amplify"
}