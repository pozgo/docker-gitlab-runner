#!/bin/sh
set -eu

# User params
USER_PARAMS="--name=\"${RUNNER_NAME}\" --url=\"${RUNNER_URL}\" --registration-token=\"${RUNNER_REGISTRATION_TOKEN}\" --executor=\"${RUNNER_EXECUTOR}\" ${RUNNER_EXTRA_PARAMS}"

RUN_CMD="gitlab-runner register --non-interactive ${USER_PARAMS}"

# Logger
log() {
  if [[ "$@" ]]; then echo "[`date +'%Y-%m-%d %T'`] $@"; else echo; fi
}

# Functions
export_token() {
  GLTOKEN=`cat /etc/gitlab-runner/config.toml | grep token | awk -F '\"' '{print $2}'`
  export TOKEN=${GLTOKEN}
  echo "GLTOKEN: ${GLTOKEN}"
}
start_runner() {
  if [[ ! -f /config/registered ]]; then 
    if [[ ${CI_TEST_MODE} == 'true' ]]; then
      log "Running in CI TEST MODE."
      log "gitlab-runner version:"
      gitlab-runner --version
      pip --version
      exit 1
    else
      log "Registering runner."
      bash -c "${RUN_CMD}"
      mkdir -p /etc/supervisor.d
      cp -f /config/gitlab-runner.conf /etc/supervisor.d/gitlab-runner.conf
      export_token
    fi
  fi
}

start_runner