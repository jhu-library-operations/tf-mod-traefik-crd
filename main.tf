resource "local_file" "crd" {
  content = file("${path.module}/templates/_crd.yaml")
  filename = format("%s/traefik/crd.yaml", var.infrastructure_output_path)
  file_permission = "0600"
}

resource "local_file" "rbac" {
  content = file("${path.module}/templates/_rbac.yaml")
  filename = format("%s/traefik/rbac.yaml", var.infrastructure_output_path)
  file_permission = "0600"
}

resource "local_file" "infakustomize" {
  content = templatefile("${path.module}/templates/_kustomization.yaml", { resources=[ "crd.yaml", "rbac.yaml" ] })
  filename = format("%s/traefik/kustomization.yaml", var.infrastructure_output_path)
  file_permission = "0600"
}

resource "local_file" "services" {
  count = length(var.namespaces)
  content = file("${path.module}/templates/_services_namespaced.yaml")
  filename = format("%s/%s/traefik/services.yaml", var.application_output_path, element(var.namespaces, count.index))
  file_permission = "0600"
}

resource "local_file" "deployments" {
  count = length(var.namespaces)
  content = file("${path.module}/templates/_deployments_namespaced.yaml")
  filename = format("%s/%s/traefik/deployments.yaml", var.application_output_path, element(var.namespaces, count.index))
  file_permission = "0600"
}

resource "local_file" "appkustomize" {
  count = length(var.namespaces)
  content = templatefile("${path.module}/templates/_kustomization.yaml", { resources = [ "services.yaml", "deployments.yaml" ] })
  filename = format("%s/%s/traefik/kustomization.yaml", var.application_output_path, element(var.namespaces, count.index))
  file_permission = "0600"
}
