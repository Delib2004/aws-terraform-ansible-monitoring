output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

output "s3_bucket" {
  value = aws_s3_bucket.artifacts.bucket
}
