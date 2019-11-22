alias gold='cd /d/projects/laradock';
alias vps='docker ps';
alias vlogs='docker-compose logs';

# 啟用 laradock
vup() {
    docker-compose up -d nginx mysql redis workspace;
    status=$(docker ps -a | grep sonarqube)
    if [ ! -z "$status" ]; then
        docker start sonarqube;
        return;
    fi
    docker run -d --name sonarqube -p 9007:9000 -p 9092:9092 sonarqube;
}

# 停止 laradock
vst() {
    docker stop sonarqube;
    docker-compose stop;
}

# 卸載所有容器
vdn() {
    docker container rm sonarqube;
    docker-compose down;
}

# 連入容器
vssh() {
    service=$1
    if [ ! -z "$service" ]; then
        winpty docker-compose exec "$service" bash; 
        return;
    fi
    winpty docker-compose exec workspace bash; 
    return;
}

# 重新 build 容器
vbd() {
    service=$1
    if [ ! -z "$service" ]; then
        docker-compose build "$service"; 
        return;
    fi
    docker-compose build workspace;
    return;
}
