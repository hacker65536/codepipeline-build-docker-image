resource "aws_iam_role" "cpl_srv_role" {
  name_prefix        = "${terraform.env}-cpl-srv-role-"
  assume_role_policy = "${data.aws_iam_policy_document.cpl_srv_role_assume.json}"
}

resource "aws_iam_role_policy" "cpl_srv_role_policy" {
  role   = "${aws_iam_role.cpl_srv_role.id}"
  policy = "${data.aws_iam_policy_document.cpl_srv_role_policy.json}"
}

resource "aws_codepipeline" "cpl" {
  name     = "${terraform.env}-cpl"
  role_arn = "${aws_iam_role.cpl_srv_role.arn}"

  artifact_store {
    location = "${aws_s3_bucket.s3.bucket}"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["myapp"]

      configuration {
        Owner  = "${lookup(var.github1,"owner")}"
        Repo   = "${lookup(var.github1,"repo")}"
        Branch = "${lookup(var.github1,"branch")}"

        #need token when first run
        OAuthToken = "${lookup(var.github1,"token")}"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name     = "Build"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      input_artifacts  = ["myapp"]
      output_artifacts = ["myappbuild"]

      configuration {
        ProjectName = "${aws_codebuild_project.cb.name}"
      }
    }
  }
}
