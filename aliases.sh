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

    del)

      third_arg=${@:(2):1}
      case $third_arg in
        c)
          #remove unused containers
          unused_container=$(docker container ps -a -q)
          if [[ $unused_containers -eq "" ]]; then
            echo "No unused containers"
          else
            docker rm $unused_containers
          fi
        ;;

        i)
          #remove <none> images
          none_images=$(docker images --filter dangling=true -q --no-trunc)
          if [[ $none_images -eq "" ]]; then
            echo "No <none> images"
          else
            docker rmi $none_images
          fi
        ;;
 
        *)
          echo 'Usage: d del c|i'
        esac

    ;;

    *)
      command docker "$@" 
    ;;
  esac
}
