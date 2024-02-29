resource "local_file" "exemplo" {
  filename = "exemplo.txt"
  content  = var.my_content
}

variable "my_content" {
  type = string
}