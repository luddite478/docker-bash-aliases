dc() {
  case $1 in
    u)
      docker-compose up
    ;;

    *)
      docker-compose "$@"
    ;;
   esac
}
