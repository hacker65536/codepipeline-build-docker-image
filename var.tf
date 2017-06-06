variable "github1" {
  default = {
    owner  = "myname"
    repo   = "myrepo"
    branch = "master"
    token  = "wudxzbdjj2k7jhuwpz25cassykvfwsbfhrbz26s8"
  }
}

variable "compute_type" {
  default = {
    small  = "BUILD_GENERAL1_SMALL"
    medium = "BUILD_GENERAL1_MEDIUM"
    large  = "BUILD_GENERAL1_LARGE"
  }
}

variable "docker_images" {
  default = {
    node   = "aws/codebuild/eb-nodejs-6.10.0-amazonlinux-64:4.0.0"
    docker = "aws/codebuild/docker:1.12.1"
    golang = "aws/codebuild/eb-go-1.6-amazonlinux-64:2.3.2"
  }
}
