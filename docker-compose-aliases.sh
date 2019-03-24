dc() {
  case $1 in
    u)
      docker-compose up
    ;;
    d)
      docker-compose down
    ;;
    *)
      docker-compose "$@"
    ;;
   esac
}
