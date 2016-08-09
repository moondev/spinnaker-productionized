
provider "docker" {

}

resource "docker_network" "private_network" {
    name = "spinnaker_network"
}

resource "docker_container" "spin-redis" {
  name = "spin-redis"
  image = "localhost:5000/redis"       
  ports = {
    internal = 6379
    external = 6379
  }
  networks = ["${docker_network.private_network.name}"]
}

resource "docker_container" "cassandra" {
  name = "spin-cassandra"
  image = "localhost:5000/cassandra-spinnaker"       
  ports = {
    internal = 9160
    external = 9160
  }
  networks = ["${docker_network.private_network.name}"]
}

resource "docker_container" "jenkins" {
  name = "spin-jenkins"
  image = "localhost:5000/jenkins-dind"       
  ports = {
    internal = 8080
    external = 8888
  }
  networks = ["${docker_network.private_network.name}"]
}

resource "docker_container" "spin-front50" {
  name = "spin-front50"
  image = "localhost:5000/front50"       
  ports = {
    internal = 8080
    external = 8080
  }
  volumes = {
      host_path = "/Users/chadmoon/forks/spinnaker-productionized/config/front50.yml"
      container_path = "/opt/front50/config/front50.yml"
  }
  networks = ["${docker_network.private_network.name}"]

  command = ["/opt/front50/bin/front50"]
}

resource "docker_container" "spin-clouddriver" {
  name = "spin-clouddriver"
  image = "localhost:5000/clouddriver"       
  ports = {
    internal = 7002
    external = 7002
  }
  volumes = {
      host_path = "/Users/chadmoon/forks/spinnaker-productionized/config/clouddriver.yml"
      container_path = "/opt/clouddriver/config/clouddriver.yml"
  }
  networks = ["${docker_network.private_network.name}"]
  command = ["/opt/clouddriver/bin/clouddriver"]
}

resource "docker_container" "spin-igor" {
  name = "spin-igor"
  image = "localhost:5000/igor"       
  ports = {
    internal = 8088
    external = 8088
  }
  networks = ["${docker_network.private_network.name}"]
  volumes = {
      host_path = "/Users/chadmoon/forks/spinnaker-productionized/config/igor.yml"
      container_path = "/opt/clouddriver/config/igor.yml"
  }
  command = ["/opt/igor/bin/igor"]
}

resource "docker_container" "spin-rosco" {
  name = "spin-rosco"
  image = "localhost:5000/rosco"       
  ports = {
    internal = 8087
    external = 8087
  }
  networks = ["${docker_network.private_network.name}"]
  volumes = {
      host_path = "/Users/chadmoon/forks/spinnaker-productionized/config/rosco.yml"
      container_path = "/opt/rosco/config/rosco.yml"
  }
  command = ["/opt/rosco/bin/rosco"]
}

resource "docker_container" "spin-orca" {
  name = "spin-orca"
  image = "localhost:5000/orca"       
  ports = {
    internal = 8083
    external = 8083
  }
  networks = ["${docker_network.private_network.name}"]
  volumes = {
      host_path = "/Users/chadmoon/forks/spinnaker-productionized/config/orca.yml"
      container_path = "/opt/orca/config/orca.yml"
  }
  command = ["/opt/orca/bin/orca"]
}

resource "docker_container" "spin-gate" {
  name = "spin-gate"
  image = "localhost:5000/gate"       
  ports = {
    internal = 8084
    external = 8084
  }
  networks = ["${docker_network.private_network.name}"]
  volumes = {
      host_path = "/Users/chadmoon/forks/spinnaker-productionized/config/gate.yml"
      container_path = "/opt/orca/config/gate.yml"
  }
  command = ["/opt/gate/bin/gate"]
}

resource "docker_container" "spin-deck" {
  name = "spin-deck"
  image = "localhost:5000/deck"       
  ports = {
    internal = 80
    external = 9000
  }
  networks = ["${docker_network.private_network.name}"]
  volumes = [
  {
      host_path = "/Users/chadmoon/forks/spinnaker-productionized/config/settings.js"
      container_path = "/usr/share/nginx/settings.js"
  },
  {
      host_path = "/Users/chadmoon/forks/spinnaker-productionized/config/nginx.conf"
      container_path = "/etc/nginx/nginx.conf"
  }
  ]
  command = ["nginx", "-g", "daemon off;"]
}