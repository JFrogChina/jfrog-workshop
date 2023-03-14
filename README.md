
# docker image for workshop

## desc

        based on centos:centos8, below tools are installed:
        
        - jfrog cli
        - java
        - maven
        - wget
        - unzip

## buid image

        - by Dockerfile

                ./build.sh

        - by commit (optional)

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

## prepare

        - jfrog artifactory access info

                e.g.
                jfrog artifactory URL = http://x.x.x.x:8082
                username/password = admin/xxxxxx
                access token = xxx.xxx.xxx

![image info](./images/token.png)

                api key = xxxxxx

![image info](./images/apikey1.png)
![image info](./images/apikey2.png)

        - repositories created

                e.g.
                app1-maven-snapshot-virtual
                app1-maven-release-virtual

![image info](./images/repo.png)

## run & configure

        1. pull / load image

                # docker login -u kyle demo.jfrogchina.com
                docker pull demo.jfrogchina.com/app1-docker-dev-local/centos:jfrog-amd64
                docker pull demo.jfrogchina.com/app1-docker-dev-local/centos:jfrog-arm64

                docker load < centos-jfrog-amd64.tar
                docker load < centos-jfrog-arm64.tar

![image info](./images/load.png)

        2. run
        
                docker run -it --name centos-jfrog-arm64 centos:jfrog-amd64 bash
                docker run -it --name centos-jfrog-arm64 centos:jfrog-arm64 bash

![image info](./images/run.png)

        3. configure jfrog cli
        
                jf c add

                e.g.
                server ID = art-china (please use this ID for later maven demo)
                access token = xxx

![image info](./images/jf-c.png)

        4. test
        
                jf c show
                jf rt ping

![image info](./images/jf-ping.png)

## maven demo

        1. preprare source code
        
                cd ~
                wget https://github.com/kyle11235/maven-example/archive/refs/heads/master.zip
                unzip master.zip
                cd maven-example-master

![image info](./images/wget.png)

                maven.yaml configured in this project for jfrog cli to work
                the serverId: art-china is already configured in jfrog cli in previous steps

![image info](./images/maven-yaml.png)

        2. build & deploy to artifactory
        
                ./cli_maven_build.sh

![image info](./images/maven-install.png)

        3. xray scan
        
                jf s multi3/target/multi3-4.7-SNAPSHOT.war

![image info](./images/jf-scan.png)


