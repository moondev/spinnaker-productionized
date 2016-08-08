
provider "docker" {
    host = "unix:///var/run/docker.sock"
}

resource "docker_container" "spin-redis" {
  name = "spinnaker-redis"
  image = "localhost:5000/redis"       
  ports = {
    internal = 6379
    external = 6379
  }
}

resource "docker_container" "cassandra" {
  name = "spinnaker-cassandra"
  image = "localhost:5000/cassandra-spinnaker"       
  ports = {
    internal = 9160
    external = 9160
  }
}

resource "docker_container" "spin-front50" {
  name = "spinnaker-front50"
  image = "localhost:5000/front50"       
  ports = {
    internal = 8080
    external = 8080
  }
  volumes = {
      host_path = "/Users/chadmoon/forks/spinnaker-productionized/config/front50.yml"
      container_path = "/opt/front50/config/front50.yml"
  }

  command = ["/opt/front50/bin/front50"]
}

resource "docker_container" "spin-clouddriver" {
  name = "spinnaker-clouddriver"
  image = "localhost:5000/clouddriver"       
  ports = {
    internal = 7002
    external = 7002
  }
  volumes = {
      host_path = "/Users/chadmoon/forks/spinnaker-productionized/config/clouddriver.yml"
      container_path = "/opt/clouddriver/config/clouddriver.yml"
  }
  command = ["/opt/clouddriver/bin/clouddriver"]
}

