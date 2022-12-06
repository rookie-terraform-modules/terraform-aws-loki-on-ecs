locals {
  loki_index_prefix = "loki-index-${var.ecs_cluster_name}-"

  loki_config = {
    auth_enabled = false
    ingester = {
      lifecycler = {
        address = "0.0.0.0"
        ring = {
          kvstore = {
            store = "inmemory"
          }
          replication_factor = 1
        }
        final_sleep = "0s"
      }
      chunk_idle_period   = "5m"
      chunk_retain_period = "30s"
    }
    schema_config = {
      configs = [
        {
          from         = "2020-01-01"
          store        = "aws"
          object_store = "s3"
          schema       = "v11"
          index = {
            prefix = local.loki_index_prefix
            period = "${24 * 7}h"
          }
        }
      ]
    }
    storage_config = {
      aws = {
        s3 = "s3://${data.aws_region.current.name}/${aws_s3_bucket.loki_chunks.bucket}"
        dynamodb = {
          dynamodb_url = "dynamodb://${data.aws_region.current.name}"
        }
      }
    }
    table_manager = {
      retention_deletes_enabled = true
      retention_period          = "${24 * 21}h"
      index_tables_provisioning = {
        enable_ondemand_throughput_mode : true
        enable_inactive_throughput_on_demand_mode : true
      }
    }
    limits_config = {
      enforce_metric_name        = false
      reject_old_samples         = true
      reject_old_samples_max_age = "168h"
    }
  }
}
