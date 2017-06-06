data "aws_iam_policy_document" "ecr" {
  statement {
    actions = [
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
    ]

    principals {
      type        = "AWS"
      identifiers = ["${aws_iam_role.cb_srv_role.arn}"]
    }
  }
}

resource "aws_ecr_repository" "ecr" {
  name = "${terraform.env}"
}

# note cycle error when set depends on
resource "aws_ecr_repository_policy" "ecrpolicy" {
  repository = "${aws_ecr_repository.ecr.name}"
  policy     = "${data.aws_iam_policy_document.ecr.json}"
  depends_on = ["aws_codebuild_project.cb"]
}
