
provider "docker" {
    host = "unix:///var/run/docker.sock"
}

resource "docker_image" "ubuntu" {
    name = "ubuntu:trusty"
}

resource "docker_container" "spin-front50" {
  name = "spin-front50"
  image = "${docker_image.ubuntu.latest}"
  command = ["ping", "localhost"]        
  ports = {
    internal = 8080
    external = 8080
  }


}

// resource "docker_container" "spinnaker-front50" {
//     image = "${docker_image.ubuntu.latest}"
//     name = "front50"
//     command = ["ping", "localhost"]        
//     ports = {
//       internal = 8080
//       external = 8080
//     }

//   provisioner "local-exec" {
//     inline = [
//       "uptime"
//     ]
//   }

//   provisioner "remote-exec" {
    // inline = [
    //   "export DEBIAN_FRONTEND=noninteractive",
    //   "sudo apt-get update",
    //   "sudo apt-get install -y git",
    //   "git",
    //   "sudo add-apt-repository -y ppa:webupd8team/java",
    //   "echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections",
    //   "sudo apt-get update",
    //   "sudo apt-get install -y oracle-java8-installer",
    //   "git clone https://github.com/spinnaker/front50.git",
    //   "cd front50 && GRADLE_USER_HOME=cache sudo ./gradlew buildDeb -x test",
    //   "sudo dpkg -i ./front50-web/build/distributions/*.deb",
    //   "rm /opt/front50/config/front50.yml",
    //   "mv /opt/front50.yml /opt/front50/config/front50.yml",
    //   "sudo /opt/front50/bin/front50 &> ~/front50.log"
//     ]
//   }
// }