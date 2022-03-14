######################################################################
# IAM 
######################################################################

resource "aws_iam_role" "iam_lambda_landing" {
  name = var.iam_lambda_landing_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid = ""
      }
    ]
  })
  tags = {
      environment = var.environment
      creator = var.creator
      type = var.type
  }
}

resource "aws_iam_role_policy" "iam_policy_lambda_landing" {
  name = var.iam_policy_lambda_landing_name
  role = aws_iam_role.iam_lambda_landing.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sqs:ChangeMessageVisibility",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:ReceiveMessage",
        ],
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy" "iam_policy_lambda_landing_logs" {
  name = var.iam_policy_lambda_landing_logs_name
  role = aws_iam_role.iam_lambda_landing.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

