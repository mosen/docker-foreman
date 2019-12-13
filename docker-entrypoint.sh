#!/usr/bin/env bash

FOREMAN_ENV=${FOREMAN_ENV:-production}
FOREMAN_PORT=${FOREMAN_PORT:-3000}
FOREMAN_BIND=0.0.0.0
SEED_ADMIN_PASSWORD=${SEED_ADMIN_PASSWORD:-changeme}

start_foreman_proxy() {
  echo "Starting Foreman Smart Proxy"
  /usr/share/foreman-proxy/bin/smart-proxy --no-daemonize
}

start_foreman() {
  echo "Running DB Migrations"
  foreman-rake db:migrate
  echo "Seeding Database"
  foreman-rake db:seed
  echo "Resetting Admin Account"
  foreman-rake permissions:reset

  echo "Starting Foreman"
  cd /usr/share/foreman && \
    /usr/bin/scl enable tfm "rails server --environment $FOREMAN_ENV --port $FOREMAN_PORT --binding $FOREMAN_BIND"
}


case "$1" in
  proxy|PROXY)
    start_foreman_proxy
    ;;
  *)
    start_foreman
    ;;
esac
