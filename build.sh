
# docker build -t centos:jfrog .

# single build
# docker buildx build --platform linux/amd64 -t centos:jfrog .

# multiple build + push to registry
# docker buildx create --use
# docker buildx build --platform linux/amd64,linux/arm64 -t centos:jfrog . --output=type=registry

# multiple build
for arch in amd64 arm64 ; do 
    docker buildx build --platform linux/$arch -t centos:jfrog-${arch} . --output type=docker; \
    docker save -o release/centos-jfrog-$arch.tar centos:jfrog-$arch
done





