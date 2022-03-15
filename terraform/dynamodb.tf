######################################################################
# DYNAMO DB 
######################################################################

resource "aws_dynamodb_table" "basic-dynamodb-table" {
    name           = var.dynamodb_name
    read_capacity  = 10
    write_capacity = 10
    hash_key       = "UserId"
    attribute {
        name = "UserId"
        type = "S"
    }
    attribute {
        name = "Email"
        type = "S"
    }
    global_secondary_index {
        name               = "EmailIndex"
        hash_key           = "Email"
        projection_type    = "ALL"
        write_capacity     = 5
        read_capacity      = 5

    }
    tags = {
        environment = var.environment
        creator = var.creator
        type = var.type
    }
}

