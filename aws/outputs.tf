resource "null_resource" "kubeconfig" {
  provisioner "local-exec" {
      command = "kubectl config set-cluster ${aws_eks_cluster.new-cluster.arn} --server=${aws_eks_cluster.new-cluster.endpoint}"
  }

  provisioner "local-exec" {
      command = "kubectl config set clusters.${aws_eks_cluster.new-cluster.arn}.certificate-authority-data ${aws_eks_cluster.new-cluster.certificate_authority.0.data}"
  }

  provisioner "local-exec" {
      command = "kubectl config set-context ${aws_eks_cluster.new-cluster.arn} --cluster=${aws_eks_cluster.new-cluster.arn} --user=${aws_eks_cluster.new-cluster.arn}"
  }

  provisioner "local-exec" {
      command = "kubectl config set-credentials ${aws_eks_cluster.new-cluster.arn} --exec-api-version='client.authentication.k8s.io/v1beta1' --exec-command='aws-iam-authenticator' --exec-arg='token' --exec-arg='-i' --exec-arg='${aws_eks_cluster.new-cluster.name}' --exec-env='AWS_PROFILE=${var.aws_profile}'"
  }

  provisioner "local-exec" {
      command = "kubectl config use-context ${aws_eks_cluster.new-cluster.arn}"
  }

  depends_on = [
    aws_eks_cluster.new-cluster
  ]
}

resource "null_resource" "remove-kubeconfig" {
  triggers = {
    cluster = aws_eks_cluster.new-cluster.arn
  }

  provisioner "local-exec" {
      when = destroy
      command = "kubectl config delete-cluster ${self.triggers.cluster}"
  }

  provisioner "local-exec" {
      when = destroy
      command = "kubectl config delete-context ${self.triggers.cluster}"
  }

  provisioner "local-exec" {
      when = destroy
      command = "kubectl config delete-user ${self.triggers.cluster}"
  }

  provisioner "local-exec" {
      when = destroy
      command = "kubectl config unset current-context"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    null_resource.kubeconfig
  ]
}