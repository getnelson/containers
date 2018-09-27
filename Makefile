
TRAVIS_BUILD_NUMBER?=999
TAG=1.0.$(TRAVIS_BUILD_NUMBER)
SRC?=$(IMAGE_SRC)

build:
	docker build $(SRC) -t "getnelson/$(SRC):$(TAG)"
