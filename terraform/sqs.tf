######################################################################
# SQS LANDING
######################################################################

resource "aws_sqs_queue" "sqs_landing" {
    name = var.sqs_landing_name
    redrive_policy = jsonencode({
        deadLetterTargetArn = aws_sqs_queue.sqs_dlq_landing.arn
        maxReceiveCount = 5
    })
    tags = {
        environment = var.environment
        creator = var.creator
        type = var.type
    }
}

resource "aws_sqs_queue" "sqs_dlq_landing" {
    name = var.sqs_dlq_landing_name
    tags = {
        environment = var.environment
        creator = var.creator
        type = var.type
    }  
}

resource "aws_sqs_queue_policy" "sqs_landing_policy" {
    queue_url = aws_sqs_queue.sqs_landing.id
    policy = jsonencode({
        Version = "2012-10-17",
        Id = "sqspolicy",
        Statement = [
            {
                Sid = "First",
                Effect = "Allow",
                Principal = "*",
                Action = "sqs:SendMessage",
                Resource = "${aws_sqs_queue.sqs_landing.arn}",
                Condition = {
                    ArnEquals = {
                        "aws:SourceArn" = "${aws_sns_topic.sns_landing_topic.arn}"
                    }
                }
            }
        ]
    })
}