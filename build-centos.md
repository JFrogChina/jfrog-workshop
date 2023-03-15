
## how to build centos-jfrog-amd64.tar ...

        - by Dockerfile

                ./build.sh

        - by commit (optional)

                1. base image

                        docker pull centos:centos8
                        docker run -it --name centos-jfrog-arm64 centos:centos8 bash

                2. install jfrog cli

                        curl -fL https://install-cli.jfrog.io | sh
                        jf c add
                        jf rt ping

                3. install jdk

                        cd /etc/yum.repos.d/
                        sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
                        sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
                        yum -y install java
                        java -version

                4. install maven

                        yum install -y maven

                5. install others

                        yum install -y wget
                        yum install -y unzip

                6. commit docker & save image

                        docker commit centos-jfrog-arm64 centos:jfrog-arm64
                        docker save -o centos-jfrog-arm64.tar centos:jfrog-arm64

