
TRAVIS_BUILD_NUMBER?=999
TAG=1.0.$(TRAVIS_BUILD_NUMBER)
SRC?=$(IMAGE_SRC)
IMAGE="getnelson/$(SRC):$(TAG)"

build:
	docker build $(SRC) -t $(IMAGE)

publish:
	docker push $(IMAGE)
