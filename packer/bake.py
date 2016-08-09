import os

os.system("./packer build base.json")

services = ('front50', 'clouddriver', 'rosco', 'igor', 'orca', 'gate') 

for service in services:
    os.system("./packer build -var 'service=" + service + "' docker.json")

os.system("./packer build deck.json")

os.system("cd ../ && terraform apply")