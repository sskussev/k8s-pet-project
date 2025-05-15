module "kube" {
  source = "git::https://github.com/terraform-yc-modules/terraform-yc-kubernetes.git"    # Путь к модулю 
  network_id = var.network_id                     # ID сети Yandex Cloud (указанов в var.network_id в файле variables)

  master_locations = [
    {
      zone      = "ru-central1-a"                         # Зона размещения мастер-ноды
      subnet_id = "e9bid6q3kp17dfn68mk6"                  # Подсеть для мастер-ноды
    }
  ]

  master_maintenance_windows = [
    {
      day        = "monday"                               # День недели для окна обслуживания
      start_time = "03:00"                                # Время начала обслуживания
      duration   = "3h"                                   # Длительность окна обслуживания
    }
  ]

  node_groups = {
    "yc-k8s-ng-02" = {                                    # Вторая группа нод (фиксированный размер)
      nat = true
      description = "Kubernetes nodes group 02 with fixed size scaling"
      fixed_scale = {
        size = 1                                          # Всегда 1 шт, если не хватит - ну печально
      }
    }
  }
}