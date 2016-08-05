export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y git
git
sudo add-apt-repository -y ppa:webupd8team/java
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get update
sudo apt-get install -y oracle-java8-installer
git clone https://github.com/spinnaker/$SERVICE.git
cd $SERVICE && GRADLE_USER_HOME=cache sudo ./gradlew buildDeb -x test
sudo dpkg -i ./$SERVICE-web/build/distributions/*.deb
rm /opt/$SERVICE/config/$SERVICE.yml
mv /opt/$SERVICE.yml /opt/$SERVICE/config/f$SERVICE.yml
sudo /opt/$SERVICE/bin/$SERVICE &> ~/$SERVICE.log