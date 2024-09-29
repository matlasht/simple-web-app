# simple-web-app
These instructions will cover usage information and for the simple docker application
## Usage

### Build
```shell
docker build -t simple-web-app:latest . 
```

### Run
```shell
docker run --rm -d -p 8080:8080/tcp --name simple-web-app simple-web-app:latest
```

### Terragrunt deployment
1. Go inside terragrunt folder
```shell
cd terragrunt
```
2. Go to needed environment folder
```shell
terragrunt init
terragrunt refresh -var-file=configuration.tfvars (optional)
```
