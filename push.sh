


# docker login -u kyle demo.jfrogchina.com
docker tag centos:jfrog-amd64 demo.jfrogchina.com/app1-docker-dev-local/centos:jfrog-amd64
docker push demo.jfrogchina.com/app1-docker-dev-local/centos:jfrog-amd64

docker tag centos:jfrog-arm64 demo.jfrogchina.com/app1-docker-dev-local/centos:jfrog-arm64
docker push demo.jfrogchina.com/app1-docker-dev-local/centos:jfrog-arm64





