#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
BOLD=$(tput bold)
NB=$(tput sgr0)
info() {
  res=$1
  if [[ $2 == bold ]]; then
    res="${BOLD}${1}${NB}"
  fi
  echo -e "${res}"
}
error() {
  res=$(info "$1" "bold")
  echo -e "${RED}${res}${NC}"
}
warning() {
  res=$(info "$1" "$2")
  echo -e "${YELLOW}${res}${NC}"
}
success() {
  res=$(info "$1" "$2")
  echo -e "${GREEN}${res}${NC}"
}

warning "*******************************" bold
warning "**   Production Deployment   **" bold
warning "*******************************" bold

# warn
echo -n "You are about to publish code to production. Proceed? [y/N]: "
read proceed
if [[ $proceed != 'y' && $proceed != 'Y' ]]; then
  error "Aborted." bold
  exit 1;
fi

git pull
npm install
npm run build

success "Production deployment complete."