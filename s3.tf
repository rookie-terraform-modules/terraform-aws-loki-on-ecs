# create loki chunk storage bucket
resource "aws_s3_bucket" "loki_chunks" {
  bucket = "loki-chunks-${var.ecs_cluster_name}"
}

# set bucket acl to private
resource "aws_s3_bucket_acl" "loki_chunks_acl" {
  bucket = aws_s3_bucket.loki_chunks.id
  acl    = "private"
}
