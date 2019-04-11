alias gold='cd /d/projects/laradock';
alias vps='docker ps';
alias vlogs='docker-compose logs';

vup() {
    docker-compose up -d nginx mysql redis workspace;
    status=$(docker ps -a | grep sonarqube)
    if [ ! -z "$status" ]; then
        docker start sonarqube;
        return;
    fi
    docker run -d --name sonarqube -p 9007:9000 -p 9092:9092 sonarqube;
}

vst() {
    docker stop sonarqube;
    docker-compose stop;
}

vdn() {
    docker container rm sonarqube;
    docker-compose down;
}

vssh() {
    service=$1
    if [ ! -z "$service" ]; then
        winpty docker-compose exec "$service" bash; 
        return;
    fi
    winpty docker-compose exec workspace bash; 
    return;
}

vbd() {
    service=$1
    if [ ! -z "$service" ]; then
        docker-compose build "$service"; 
        return;
    fi
    docker-compose build workspace;
    return;
}
