# Configure the Nomad provider
provider "nomad" {
  address = "http://localhost:4646"
}

variable "version" {
  default = "latest"
}

data "template_file" "job" {
  template = "${file("./http-echo.hcl.tmpl")}"

  vars {
    version = "${var.version}"
  }
}

# Register a job
resource "nomad_job" "http-echo" {
  jobspec = "${data.template_file.job.rendered}"
}
