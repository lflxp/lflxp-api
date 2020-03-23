install: asset
	cp cmd/main.go .
	go install
	rm -f main.go

build: asset
	cd cmd && go build && mv cmd ../lflxp-api

asset: bindata clean
	cd pkg/static && go-bindata -o=../asset.go -pkg=pkg ./

bindata:
	@echo 安装预制环境
	go get -u github.com/jteeuwen/go-bindata/...
	go get -u github.com/elazarl/go-bindata-assetfs/...

push: asset pull
	git add .
	git commit -m "${m}"
	git push origin $(shell git branch|grep '*'|awk '{print $$2}')

pull:
	git pull origin $(shell git branch|grep '*'|awk '{print $$2}')

clean:
	rm -f cmd/cmd
	rm -f pkg/asset.go
