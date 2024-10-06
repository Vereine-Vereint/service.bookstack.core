#!/bin/bash
SERVICE_NAME="bookstack"
SERVICE_VERSION="v1.1"

set -e

SERVICE_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
echo "[$SERVICE_NAME] $SERVICE_VERSION ($(git rev-parse --short HEAD))"
cd $SERVICE_DIR

# CORE
source ./core/core.sh

# VARIABLES
set -o allexport
# set variables for docker or other services here
MYSQL_DATABASE="bookstackapp"
MYSQL_USER="bookstack"
set +o allexport

# COMMANDS

# This is an example command that prints a message from the first argument
commands+=([exec-db]="<msg>: Execute a command in the database container")
cmd_exec-db() {
  docker compose exec -it bookstack-db bash -c "mariadb -u root -p${MYSQL_ROOT_PASSWORD}"
}

commands+=([upgrade-db]="<msg>: Execute mariadb-upgrade -u root -p<PASSWORD>")
cmd_upgrade-db() {
  docker compose exec -it bookstack-db bash -c "mariadb-upgrade -u root -p${MYSQL_ROOT_PASSWORD}"
}


# ATTACHMENTS

# Setup function that is called before the docker up command
# att_setup() {
#   echo "Setting up..."
# }

# Configure function that is called before the docker up, start and restart commands
# att_configure() {
#   echo "Configuring..."
# }

# MAIN
main "$@"
