#!/bin/bash

# *********** 批量替换docker-compose.yaml的镜像名字
# 用途：适用于内网等拉不下镜像的场景，批量加一个代理前缀可以辅助镜像拉取
# 参数：$1 docker-compose.yaml的路径，不传入，默认为当前路径下的docker-compose.yaml


# 定义要添加的前缀, 需要修改这个变量值 
PREFIX="dockerproxy.com/"

# 检查是否提供了docker-compose.yml文件路径
path=`$pwd`\docker-compose.yaml
if [ -n "$1" ]; then
  path=$1
fi

DOCKER_COMPOSE_FILE=$path

# 使用sed命令替换image字段
sed -i -E "s|image: ([^[:space:]]+)|image: ${PREFIX}\1|g" "$DOCKER_COMPOSE_FILE"

echo "Updated images in $DOCKER_COMPOSE_FILE with prefix $PREFIX"