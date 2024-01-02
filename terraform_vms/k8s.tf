resource "yandex_kubernetes_cluster" "k8s-regional" {
  name = "k8s-regional"
  network_id = yandex_vpc_network.cloudvpc.id
  master {
    public_ip = true
    regional {
      region = "ru-central1"
      location {
        zone      = var.zone1a
        subnet_id = yandex_vpc_subnet.k8snet01.id
      }
      location {
        zone      = var.zone1b
        subnet_id = yandex_vpc_subnet.k8snet02.id
      }
      location {
        zone      = var.zone1d
        subnet_id = yandex_vpc_subnet.k8snet03.id
      }
    }
    security_group_ids = [yandex_vpc_security_group.sgcloud.id]
  }
  service_account_id      = yandex_iam_service_account.sa.id
  node_service_account_id = yandex_iam_service_account.sa.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_member.vpc-public-admin,
    yandex_resourcemanager_folder_iam_member.images-puller,
    yandex_resourcemanager_folder_iam_member.encrypterDecrypter
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.key-a.id
  }
}


resource "yandex_kubernetes_node_group" "nodegroup" {
  cluster_id = yandex_kubernetes_cluster.k8s-regional.id
  name       = "nodegroup"
  instance_template {
    name       = "node-{instance.index}"
    platform_id = "standard-v1"
    network_acceleration_type = "standard"
    
    container_runtime {
      type = "containerd"
    }
    # labels {
    #   "<имя_метки>"="<значение_метки>"
    # }
    resources {
      memory = 4
      cores  = 2
    }
    metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = "ubuntu:${var.metadata.ssh-keys}"
    }
    network_interface {
      nat                = false
      subnet_ids         = ["${yandex_vpc_subnet.k8snet01.id}"]
      security_group_ids = [yandex_vpc_security_group.sgcloud.id]
      
    }
  }
  allocation_policy {
    location {
      zone = var.zone1a
    }
  }
  
  scale_policy {
    auto_scale {
      min     = 3
      max     = 6
      initial = 3
    }
  }
  
}