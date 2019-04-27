d() {
  case $1 in
    c)
      docker container "${@:2}" 
    ;;
    i)
      docker image "${@:2}"  
    ;;
    r)
      docker run "${@:2}"
    ;;
    b) 
      docker build "${@:2}" 
    ;;
    e)
      docker exec "${@:2}" 
    ;;
    n)
      third_arg=${@:(2):1}
      case $third_arg in
        p)
          docker network prune
        ;;
        *)
          docker network "${@:2}" 
        ;;
      esac
    ;;
    p)
      docker system prune
    ;;
    s)
      third_arg=${@:(2):1}
      case $third_arg in
        a)
          running_containers=$(docker ps -q)
          if [[ $running_containers == "" ]]; then 
            echo "no running containers"
          else
            fourth_arg=${@:(3):1}
            case $fourth_arg in
              rm)
                docker stop $running_containers > /dev/null
                docker rm $running_containers > /dev/null
                echo stopped and removed $running_containers
              ;;
              *)
                docker stop $running_containers > /dev/null
                echo stopped $running_containers
              ;;
            esac
          fi
        ;;
        *)
          docker stop "${@:2}"
        ;;
      esac
    ;;
    *)
      command docker "$@" 
    ;;
  esac
}
