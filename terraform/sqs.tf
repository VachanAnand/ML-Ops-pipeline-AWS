######################################################################
# SQS DB
######################################################################

resource "aws_sqs_queue" "sqs_db" {
    name = var.sqs_db_name
    redrive_policy = jsonencode({
        deadLetterTargetArn = aws_sqs_queue.sqs_db_dlq.arn
        maxReceiveCount = 5
    })
    depends_on = [aws_sqs_queue.sqs_db_dlq]
    tags = {
        environment = var.environment
        creator = var.creator
        type = var.type
    }
}

resource "aws_sqs_queue" "sqs_db_dlq" {
    name = var.sqs_db_dlq_name
    tags = {
        environment = var.environment
        creator = var.creator
        type = var.type
    }  
}

######################################################################
# SQS S3 dl (Data Lake)
######################################################################


resource "aws_sqs_queue" "sqs_dl" {
    name = var.sqs_dl_name
    redrive_policy = jsonencode({
        deadLetterTargetArn = aws_sqs_queue.sqs_dl_dlq.arn
        maxReceiveCount = 5
    })
    depends_on = [aws_sqs_queue.sqs_dl_dlq]
    tags = {
        environment = var.environment
        creator = var.creator
        type = var.type
    }
}

resource "aws_sqs_queue" "sqs_dl_dlq" {
    name = var.sqs_dl_dlq_name
    tags = {
        environment = var.environment
        creator = var.creator
        type = var.type
    }  
}

######################################################################
# SQS QUE POLICY
######################################################################
resource "aws_sqs_queue_policy" "sqs_db_policy" {
    queue_url = aws_sqs_queue.sqs_db.id
    policy = jsonencode({
        Version = "2012-10-17",
        Id = "sqspolicy",
        Statement = [
            {
                Sid = "First",
                Effect = "Allow",
                Principal = "*",
                Action = "sqs:SendMessage",
                Resource = ["${aws_sqs_queue.sqs_db.arn}"],
                Condition = {
                    ArnEquals = {
                        "aws:SourceArn" = "${aws_sns_topic.sns_topic.arn}"
                    }
                }
            }
        ]
    })
}

resource "aws_sqs_queue_policy" "sqs_dl_policy" {
    queue_url = aws_sqs_queue.sqs_dl.id
    policy = jsonencode({
        Version = "2012-10-17",
        Id = "sqspolicy",
        Statement = [
            {
                Sid = "First",
                Effect = "Allow",
                Principal = "*",
                Action = "sqs:SendMessage",
                Resource = ["${aws_sqs_queue.sqs_dl.arn}"],
                Condition = {
                    ArnEquals = {
                        "aws:SourceArn" = "${aws_sns_topic.sns_topic.arn}"
                    }
                }
            }
        ]
    })
}