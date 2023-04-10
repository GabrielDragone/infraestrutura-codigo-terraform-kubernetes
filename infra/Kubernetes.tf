resource "kubernetes_deployment" "Django-API" {
  metadata {
    name = "django-api"
    labels = {
      nome = "django"
    }
  }

  # Aqui falamos da nossa aplicação:
  spec {
    replicas = 3 # Qnts vezes a aplicação está rodando ao mesmo tempo.

    selector {
      match_labels = {
        nome = "django" # Interliga com metadata
      }
    }

    template {
      metadata {
        labels = {
          nome = "django"
        }
      }

      spec { # Especificações
        container {
          image = "nginx:1.21.6" # Imagem da aplicação. Se tivermos subido alguma, podemos utilizar ela aqui. Aqui estamos usando uma padrão do docker
          name  = "django"

          resources { # Recursos
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get { # Tipo o health check do Bitbucket.
              path = "/" # Path da api
              port = 80 # Mesma porta do container

              http_header { # Se quiser costumizar o header
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3 # Numeros de segundos dps que o container subiu pro liveness checar o container
            period_seconds        = 3 # A frequencia em segundos pra executar a probe. Uma a cada 3s. Tomar cuidado se aplicação for mto pesada pra nao rodar muitas vezes.
          }
        }
      }
    }
  }
}