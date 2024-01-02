
resource "yandex_compute_instance" "nat-instance" {
  name        = local.vm_nat_name
  platform_id = "standard-v3"
  zone        = "ru-central1-a"
  allow_stopping_for_update = true
  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public01.id
    security_group_ids = [yandex_vpc_security_group.sgcloud.id]
    nat                = true
    ip_address = local.vm_nat_ip
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = "ubuntu:${var.metadata.ssh-keys}"
  }
}