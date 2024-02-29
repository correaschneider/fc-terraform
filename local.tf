resource "local_file" "example" {
  filename = "example.txt"
  content  = var.my_content
}

data "local_file" "example-content" {
  filename = "example.txt"
}

output "data-source-result" {
  value = data.local_file.example-content.content
}

variable "my_content" {
  type = string
}

output "id-file" {
  value = resource.local_file.example.id
}

output "my_content" {
  value = resource.local_file.example.content
}