data "template_file" "loki_dockerfile" {
  template = file("${path.module}/loki-dockerfile.tpl")
  vars = {
    loki_version = var.loki_version
  }
}

# write the dockerfile to disk
resource "local_file" "loki_dockerfile" {
  content  = data.template_file.loki_dockerfile.rendered
  filename = "${path.module}/Dockerfile"
}

# write the loki config yaml to disk
resource "local_file" "loki_config" {
  content  = yamlencode(local.loki_config)
  filename = "${path.module}/loki-config.yaml"
}
