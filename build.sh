#!/bin/bash

show_help() {
    echo "Usage: ./build.sh [COMMAND]"
    echo "Commands:"
    echo "  install                                                     Install Docker"
    echo "  build_image                                                 Build Docker image"
    echo "  build_container                                             Create and run Docker container"
    echo "  start                                                       Start Docker container"
    echo "  stop                                                        Stop Docker container"
    echo "  change_usermod                                              Add current user to Docker group"
    echo "  copy <path_to_your_file>                                    Copy file into container's root directory"
    echo "  copy_from <container_file_path> <local_destination_path>    Copy file from container to local directory"
    echo "  --help                                                      Display this help message"
}

install_docker() {
    echo "Installing Docker..."
    sudo apt update
    sudo apt install -y docker.io
    echo "Docker installed successfully."
}

build_image() {
    echo "Building Docker image..."
    sudo docker build -t dissco_image .
    echo "Docker image built successfully."
}

build_container() {
    echo "Creating and running Docker container..."
    sudo docker run -it --rm --name dissco_container -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix dissco_image
    echo "Docker container is running."
}

start_container() {
    echo "Starting Docker container..."
    sudo docker start dissco_container
    xhost +local:docker
    sudo docker exec -it dissco_container /bin/bash
    echo "Docker container started."
}

stop_container() {
    echo "Stopping Docker container..."
    sudo docker stop dissco_container
    echo "Docker container stopped."
}

change_usermod() {
    echo "Adding current user to Docker group..."
    sudo usermod -aG docker $USER
    echo "User added to Docker group. Please log out and log back in for the changes to take effect."
}

copy_file() {
    if [ $# -ne 2 ]; then
        echo "Usage: $0 copy <path_to_your_file>"
        exit 1
    fi
    local_file=$2
    container_name="dissco_container"
    echo "Copying file $local_file to container $container_name root directory..."
    sudo docker cp $local_file $container_name:/root/
    echo "File copied successfully. Starting container $container_name..."
}

copy_from_container() {
    if [ $# -ne 3 ]; then
        echo "Usage: $0 copy_from <container_file_path> <local_destination_path>"
        exit 1
    fi
    container_file_path=$2
    local_destination_path=$3
    container_name="dissco_container"
    echo "Copying file from $container_file_path in container $container_name to $local_destination_path..."
    sudo docker cp $container_name:$container_file_path $local_destination_path
    echo "File copied successfully."
}

if [ $# -eq 0 ]; then
    show_help
    exit 1
fi

case $1 in
    install) install_docker ;;
    build_image) build_image ;;
    build_container) build_container ;;
    start) start_container ;;
    stop) stop_container ;;
    change_usermod) change_usermod ;;
    copy) copy_file $@ ;;
    copy_from) copy_from_container $@ ;;
    --help) show_help ;;
    *) echo "Invalid command. Use --help to see the list of available commands." ;;
esac
