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
    clr)

      third_arg=${@:(2):1}
      case $third_arg in
        c)
          #remove unused containers
          unused_containers=$(docker container ps -a -q)
          if [[ $unused_containers == "" ]]; then
            echo "No unused containers"
          else
            docker rm $unused_containers
          fi
        ;;

        i)
          #remove <none> images
          none_images=$(docker images --filter dangling=true -q --no-trunc)
          if [[ $none_images == "" ]]; then
            echo "No <none> images"
          else
            docker rmi $none_images
          fi
        ;;
 
        *)
          echo 'Usage: d clr c|i'
        esac

    ;;

    *)
      command docker "$@" 
    ;;
  esac
}
