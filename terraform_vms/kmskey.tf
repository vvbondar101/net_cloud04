resource "yandex_kms_symmetric_key" "key-a" {
  name              = "key01"
  description       = "key-for-bucket"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
  lifecycle {
    prevent_destroy = true
  }
}
