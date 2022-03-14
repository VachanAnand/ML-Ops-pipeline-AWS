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
# LANDING VARIABLES
######################################################################

variable s3_bucket_name {
  type        = string
  default     = "ml-pipeline"
  description = "S3 bucket name for machine learning pipeline demo"
}

variable sns_landing_name {
  type        = string
  default     = "sns-landing"
  description = "Name of SNS used when data lands in s3"
}

variable sqs_landing_name {
  type        = string
  default     = "sqs-landing"
  description = "Name of SQS used when data lands in s3"
}

variable sqs_dlq_landing_name {
  type        = string
  default     = "sqs-dlq-landing"
  description = "Name of SQS dead letter queue used when data lands in s3"
}

variable lambda_landing_name {
  type        = string
  default     = "lambda-landing"
}

variable iam_lambda_landing_name {
  type        = string
  default     = "iam-lambda-landing"
}

variable iam_policy_lambda_landing_name {
  type        = string
  default     = "iam-policy-lambda-landing"
}

variable iam_policy_lambda_landing_logs_name {
  type        = string
  default     = "iam-policy-lambda-landing-logs"
}