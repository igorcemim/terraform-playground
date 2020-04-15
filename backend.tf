terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "igor"

    workspaces {
      name = "terraform-playground"
    }
  }
}
