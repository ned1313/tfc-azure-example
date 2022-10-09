data "environment_variables" "all" {}

resource "null_resource" "environment_variables" {
  triggers = [data.environment_variables.all.items]

  provisioner "local-exec" {
    command = "echo ${data.environment_variables.all.items}"
  }
}

resource "local_file" "workspace_token" {
  content = data.environment_variables.all.items["TFC_WORKLOAD_IDENTITY_TOKEN"]
  filename = "~/.azure/token"
}