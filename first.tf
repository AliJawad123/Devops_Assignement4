
provider "aws" {
  region = "us-east-1a (use1-az2)"
}

resource "aws_iam_user" "terraform_credential" {
  name = "terraform-cs423-devops"
}

resource "aws_iam_user_policy_attachment" "attach_admin_policy" {
  user       = aws_iam_user.terraform_credential.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_access_key" "access_key" {
  user = aws_iam_user.terraform_credential.name
}

resource "aws_iam_user_login_profile" "login_profile" {
  user                    = aws_iam_user.terraform_credential.name
  password_reset_required = true
}
