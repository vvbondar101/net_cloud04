# resource "yandex_mdb_mysql_cluster" "clustermysql" {
#   name                = "mysql"
#   environment         = "PRESTABLE"
#   network_id          = yandex_vpc_network.cloudvpc.id
#   version             = "8.0"
#   security_group_ids  = [ "${yandex_vpc_security_group.sgcloud.id}" ]
#   deletion_protection = true

#   resources {
#     resource_preset_id = "s1.micro"
#     disk_type_id       = "network-ssd"
#     disk_size          = "10"
#   }

#   host {
#     zone             = var.zone1a
#     subnet_id        = yandex_vpc_subnet.privatenet01.id
#     assign_public_ip = false
#   }
#   host {
#     zone             = var.zone1b
#     subnet_id        = yandex_vpc_subnet.privatenet02.id
#     assign_public_ip = false
#   }
#   backup_window_start {
#     hours   = "23"
#     minutes = "59"
#   }
# }

# resource "yandex_mdb_mysql_database" "DB01" {
#   cluster_id = yandex_mdb_mysql_cluster.clustermysql.id
#   name       = "netology_db"
# }

# resource "yandex_mdb_mysql_user" "user1" {
#   cluster_id = yandex_mdb_mysql_cluster.clustermysql.id
#   name       = "user1"
#   password   = "user1user1"
#   permission {
#     database_name = yandex_mdb_mysql_database.DB01.name
#     roles         = ["ALL"]
#   }
# }
