######################################################################
# ECR  
######################################################################

resource "aws_ecr_repository" "ecr_database" {
    name = var.ecr_db_name
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration {
      scan_on_push = true
    }
    tags = {
        environment = var.environment
        creator = var.creator
        type = var.type
    }  
}

resource "aws_ecr_repository" "ecr_datalake" {
    name = var.ecr_dl_name
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration {
      scan_on_push = true
    }
    tags = {
        environment = var.environment
        creator = var.creator
        type = var.type
    }  
}

resource "aws_ecr_repository" "ecr_amplify_load" {
    name = var.ecr_amplify_name
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration {
      scan_on_push = true
    }
    tags = {
        environment = var.environment
        creator = var.creator
        type = var.type
    }  
}