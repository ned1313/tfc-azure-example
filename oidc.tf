data "environment_variables" "all" {}

resource "local_file" "workspace_token" {
  content  = data.environment_variables.all.items["TFC_WORKLOAD_IDENTITY_TOKEN"]
  filename = "~/.azure/token"
}