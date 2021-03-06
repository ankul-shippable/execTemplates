#
# Used to generate the boot script that brings up the task container
#

boot() {
  ret=0
  is_success=false

  if [ "$TASK_CONTAINER_IMAGE_SHOULD_PULL" == true ]; then
    exec_cmd "sudo docker pull $TASK_CONTAINER_IMAGE"
  fi

  exec_cmd "sudo docker run $TASK_CONTAINER_OPTIONS $TASK_CONTAINER_IMAGE $TASK_CONTAINER_COMMAND"
  ret=$?
  trap before_exit EXIT
  [ "$ret" != 0 ] && return $ret;

  is_success=true
}

trap before_exit EXIT
exec_grp "boot" "Booting up container for task: $TASK_NAME" "true"
