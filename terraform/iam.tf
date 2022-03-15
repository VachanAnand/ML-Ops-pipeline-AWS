######################################################################
# IAM 
######################################################################

resource "aws_iam_role" "iam_lambda" {
  name = var.iam_lambda_name
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

resource "aws_iam_role_policy" "iam_policy_lambda" {
  name = var.iam_policy_lambda_name
  role = aws_iam_role.iam_lambda.id
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

resource "aws_iam_role_policy" "iam_policy_lambda_logs" {
  name = var.iam_policy_lambda_logs_name
  role = aws_iam_role.iam_lambda.id
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


resource "aws_iam_role_policy" "iam_policy_lambda_dynamodb" {
  name = var.iam_policy_lambda_dynamodb_name
  role = aws_iam_role.iam_lambda.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement =[{
      Effect = "Allow",
      Action = [
        "dynamodb:BatchGetItem",
        "dynamodb:GetItem",
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:BatchWriteItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem"
      ],
      Resource = "*"
    }
    ]
  })
}