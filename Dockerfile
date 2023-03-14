FROM centos:centos8

RUN curl -fL https://install-cli.jfrog.io | sh; \
cd /etc/yum.repos.d/;\
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*; \
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*; \
yum -y install java; \
yum install -y maven; \
yum install -y wget; \
yum install -y unzip

CMD ["/bin/bash"]
