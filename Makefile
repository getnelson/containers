
TRAVIS_BUILD_NUMBER?=999
TAG=2.0.$(TRAVIS_BUILD_NUMBER)
SRC?=$(IMAGE_SRC)
IMAGE="getnelson/$(SRC):$(TAG)"

build:
	mkdir -p $(IMAGE_SRC)/.build/ && \
	cp $(PWD)/common/entrypoint.sh $(IMAGE_SRC)/.build/entrypoint.sh && \
	cp $(IMAGE_SRC)/* $(IMAGE_SRC)/.build/ && \
	docker build $(IMAGE_SRC)/.build/ -t $(IMAGE)

test: build
	docker run --rm -it -v `pwd`:/templates $(IMAGE)\
	 --file /templates/$(IMAGE_SRC)/test.template \
	 --vault-addr https://vault.yourcompany.com \
	 --vault-token "fake-token"

publish:
	docker push $(IMAGE)
