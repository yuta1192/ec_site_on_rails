# dbをpg指定
terraform {
  backend "pg" {
  }
}

# heroku使用
terraform {
  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 4.0"
    }
  }
}

# terraform apply​ コマンドに指定
variable "example_app_name" {
  description = "Name of the Heroku app provisioned as an example"
}

resource "heroku_app" "superecsite" {
  name   = "${var.example_app_name}-ecsite"
  region = "us"
}

# Build code & release to the app
resource "heroku_build" "superecsite-build" {
  app        = heroku_app.superecsite.name
  buildpacks = ["https://github.com/mars/create-react-app-buildpack.git"]

  source {
    url     = "https://github.com/mars/cra-example-app/archive/v2.1.1.tar.gz"
    version = "2.1.1"
  }
}

# Launch the app's web process by scaling-up
resource "heroku_formation" "superecsite" {
  app        = heroku_app.superecsite.name
  type       = "web"
  quantity   = 1
  size       = "Standard-1x"
  depends_on = [heroku_build.superecsite-build]
}

output "example_app_url" {
  value = "https://${heroku_app.superecsite.name}.herokuapp.com"
}
