
resource "yandex_vpc_network" "cloudvpc" {
  name = var.vpc_name
}


resource "yandex_vpc_subnet" "privatenet01" {
  name           = var.privatenet1
  zone           = var.zone1a
  network_id     = yandex_vpc_network.cloudvpc.id
  v4_cidr_blocks = var.priv1_cidr
  #route_table_id = yandex_vpc_route_table.nat-instance-route.id
}

resource "yandex_vpc_subnet" "privatenet02" {
  name           = var.privatenet2
  zone           = var.zone1b
  network_id     = yandex_vpc_network.cloudvpc.id
  v4_cidr_blocks = var.priv2_cidr
}

resource "yandex_vpc_subnet" "public01" {
  name           = var.pubnet1
  zone           = var.zone1a
  network_id     = yandex_vpc_network.cloudvpc.id
  v4_cidr_blocks = var.pub1_cidr
  
}
resource "yandex_vpc_subnet" "k8snet01" {
  name           = var.k8snet1
  zone           = var.zone1a
  network_id     = yandex_vpc_network.cloudvpc.id
  v4_cidr_blocks = var.k8s1_cidr
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}
resource "yandex_vpc_subnet" "k8snet02" {
  name           = var.k8snet2
  zone           = var.zone1b
  network_id     = yandex_vpc_network.cloudvpc.id
  v4_cidr_blocks = var.k8s2_cidr
  
}

resource "yandex_vpc_subnet" "k8snet03" {
  name           = var.k8snet3
  zone           = var.zone1d
  network_id     = yandex_vpc_network.cloudvpc.id
  v4_cidr_blocks = var.k8s3_cidr
  
}
resource "yandex_vpc_security_group" "sgcloud" {
  name       = var.sg_name
  network_id = yandex_vpc_network.cloudvpc.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-http"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-https"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }
  ingress {
    description    = "MySQL"
    port           = 3306
    protocol       = "TCP"
    v4_cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    protocol          = "TCP"
    description       = "Правило разрешает проверки доступности с диапазона адресов балансировщика нагрузки. Нужно для работы отказоустойчивого кластера Managed Service for Kubernetes и сервисов балансировщика."
    predefined_target = "loadbalancer_healthchecks"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ANY"
    description       = "Правило разрешает взаимодействие мастер-узел и узел-узел внутри группы безопасности."
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ANY"
    description       = "Правило разрешает взаимодействие под-под и сервис-сервис. Укажите подсети вашего кластера Managed Service for Kubernetes и сервисов."
    v4_cidr_blocks    = concat(yandex_vpc_subnet.k8snet01.v4_cidr_blocks, yandex_vpc_subnet.k8snet02.v4_cidr_blocks, yandex_vpc_subnet.k8snet03.v4_cidr_blocks)
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ICMP"
    description       = "Правило разрешает отладочные ICMP-пакеты из внутренних подсетей."
    v4_cidr_blocks    = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  }
  ingress {
    protocol          = "TCP"
    description       = "Правило разрешает входящий трафик из интернета на диапазон портов NodePort. Добавьте или измените порты на нужные вам."
    v4_cidr_blocks    = ["0.0.0.0/0"]
    from_port         = 30000
    to_port           = 32767
  }
  egress {
    protocol          = "ANY"
    description       = "Правило разрешает весь исходящий трафик. Узлы могут связаться с Yandex Container Registry, Yandex Object Storage, Docker Hub и т. д."
    v4_cidr_blocks    = ["0.0.0.0/0"]
    from_port         = 0
    to_port           = 65535
  }
}
