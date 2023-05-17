sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce --nobest --allowerasing -y
systemctl enable docker
systemctl start docker
systemctl status docker
