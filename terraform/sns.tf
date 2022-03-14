data "aws_iam_policy_document" "sns_policy_landing" {
    policy_id = "__default_policy_ID"
    statement {
        actions = [
            "SNS:Subscribe",
            "SNS:SetTopicAttributes",
            "SNS:RemovePermission",
            "SNS:Receive",
            "SNS:Publish",
            "SNS:ListSubscriptionsByTopic",
            "SNS:GetTopicAttributes",
            "SNS:DeleteTopic",
            "SNS:AddPermission"
        ]
        effect = "Allow"
        principals {
            type        = "AWS"
            identifiers = ["*"]
        }
        resources = [ aws_sns_topic.sns_landing_topic.arn ]
        condition {
            test     = "ArnLike"
            variable = "aws:SourceArn"
            values = [ aws_s3_bucket.s3_ml_pipeline.arn ]
        }
        sid = "__default_statement_ID"
    }
}

######################################################################
# SNS 
######################################################################

resource "aws_sns_topic" "sns_landing_topic" {
    name = var.sns_landing_name
    tags = {
        environment = var.environment
        creator = var.creator
        type = var.type
    }
}

resource "aws_sns_topic_policy" "sns_landing_topic_policy" {
    arn = aws_sns_topic.sns_landing_topic.arn
    policy = data.aws_iam_policy_document.sns_policy_landing.json
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
    topic_arn = aws_sns_topic.sns_landing_topic.arn
    protocol  = "sqs"
    endpoint  = aws_sqs_queue.sqs_landing.arn
}
