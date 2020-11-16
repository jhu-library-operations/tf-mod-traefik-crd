resource "local_file" "crd" {
  content = file("${path.module}/templates/_crd.yaml")
  filename = format("%s/crd.yaml", var.output_path)
  file_permission = "0600"
}

resource "local_file" "definitions" {
  content = file("${path.module}/templates/_definitions.yaml")
  filename = format("%s/definitions.yaml", var.output_path)
  file_permission = "0600"
}

resource "local_file" "resources" {
  content = file("${path.module}/templates/_resources.yaml")
  filename = format("%s/resources.yaml", var.output_path)
  file_permission = "0600"
}

resource "local_file" "kustomize" {
  content = file("${path.module}/templates/_kustomization.yaml")
  filename = format("%s/kustomization.yaml", var.output_path)
  file_permission = "0600"
}
