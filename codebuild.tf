resource "aws_iam_role" "cb_srv_role" {
  name_prefix        = "${terraform.env}-cb-srv-role-"
  assume_role_policy = "${data.aws_iam_policy_document.cb_srv_role_assume.json}"
}

resource "aws_iam_role_policy" "cb_srv_role_policy" {
  role   = "${aws_iam_role.cb_srv_role.id}"
  policy = "${data.aws_iam_policy_document.cb_srv_role_policy.json}"
}

resource "aws_codebuild_project" "cb" {
  name          = "${terraform.env}-cb"
  description   = "build-docker-img"
  build_timeout = "10"
  service_role  = "${aws_iam_role.cb_srv_role.arn}"
  depends_on    = ["aws_iam_role.cb_srv_role"]

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "${lookup(var.compute_type,"small")}"
    image        = "${lookup(var.docker_images,"docker")}"
    type         = "LINUX_CONTAINER"

    environment_variable {
      "name"  = "ECR_REPO_URL"
      "value" = "${aws_ecr_repository.ecr.repository_url}"
    }
  }

  source {
    type = "CODEPIPELINE"
  }

  tags = "${var.tags}"
}
