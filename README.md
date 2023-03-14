
# docker image for workshop

- desc

        based on centos:centos8, below tools are installed:
        
        - jfrog cli
        - java
        - maven
        - wget
        - unzip

- buid image by Dockerfile

        ./build.sh

- build image by commit (optional)

        - base image

                docker pull centos:centos8
                docker run -it --name centos-jfrog-arm64 centos:centos8 bash

        - install jfrog cli

                curl -fL https://install-cli.jfrog.io | sh
                jf c add
                jf rt ping

        - install jdk

                cd /etc/yum.repos.d/
                sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
                sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
                yum -y install java
                java -version

        - install maven

                yum install -y maven

        - install others

                yum install -y wget
                yum install -y unzip

        - commit docker & save image

                docker commit centos-jfrog-arm64 centos:jfrog-arm64
                docker save -o centos-jfrog-arm64.tar centos:jfrog-arm64

        - load image

            docker load < centos-jfrog-arm64.tar

- run
        
        - run
        
                docker run -it --name centos-jfrog-arm64 centos:jfrog-amd64 bash
                docker run -it --name centos-jfrog-arm64 centos:jfrog-arm64 bash
        
        - configure jfrog cli
        
                jf c add

                e.g.
                server ID = art-china (please use this ID for later maven demo)
                access token = xxx

        - test
        
                jf c show
                jf rt ping

- maven demo

        1. preprare source code
        
                cd ~
                wget https://github.com/kyle11235/maven-example/archive/refs/heads/master.zip
                unzip ...
                cd maven-example

        2. build & deploy to artifactory
        
                ./cli_maven_build.sh

        3. xray scan
        
                jf s multi3/target/multi3-4.7-SNAPSHOT.war

