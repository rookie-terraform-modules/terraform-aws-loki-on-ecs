provider "docker" {
  registry_auth {
    address  = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_caller_identity.current.region}.amazonaws.com"
    username = data.aws_ecr_authorization_token.current.user_name
    password = data.aws_ecr_authorization_token.current.password
  }
}
