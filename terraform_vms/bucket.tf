# resource "yandex_iam_service_account" "sa" {
#   name = "srcac01"
# }

# // Assigning roles to the service account
# resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
#   folder_id = var.folder_id
#   role      = "storage.editor"
#   member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
# }

# // Creating a static access key
# resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
#   service_account_id = yandex_iam_service_account.sa.id
#   description        = "static access key for object storage"
# }

# resource "yandex_resourcemanager_folder_iam_member" "admin" {
#   folder_id = var.folder_id
#   role      = "kms.keys.encrypterDecrypter"
#   member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
# }

# // Creating a bucket using the key
# resource "yandex_storage_bucket" "test" {
#   access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
#   secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
#   bucket     = "bondarcl03"
#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         kms_master_key_id = yandex_kms_symmetric_key.key-a.id
#         sse_algorithm     = "aws:kms"
#       }
#     }
#   }
# }

# resource "yandex_storage_object" "test-object" {
#   access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
#   secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
#   bucket     = "bondarcl03"
#   key        = "testjpg.jpeg"
#   source     = "./scale_1200.jpeg"
#   #acl        = "public-read"
#   depends_on = [
#     yandex_storage_bucket.test
#   ]
# }