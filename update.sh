#!/bin/sh
# Update existing SendWA installation
PROJECT_NAME="SendWA"
if [ -d "/opt/sendwa" ]; then
  . /opt/sendwa/file.env
elif [ -d "$HOME/.sendwa" ]; then
  . $HOME/.sendwa/file.env
fi
_info() {
  printf "%s\n" "$(date +"[%d %b %Y %l:%M:%S %p %Z]") $*"
}
_grab() {
  _link="$1"
  if command -v curl >/dev/null 2>&1; then
    case "$_link" in
      *file.env) wget -qO- "$_link";;
      *SendWA) wget -q -O "$WA_INSTALL_DIR/sendwa.sh" "$_link";;
    esac
  elif command -v wget >/dev/null 2>&1; then
    case "$_link" in
      *file.env) curl -kLs "$_link";;
      *SendWA) curl -kLs "$_link" -o "$WA_INSTALL_DIR/sendwa.sh";;
    esac
  else
    _info "Please install wget or curl"
    exit 1
  fi
}
# Check if sha match
if [ -n "$GIT_SHA" ]; then
  REMOTE_SHA=$(_grab "https://raw.githubusercontent.com/L1so/SendWA/main/file.env" | grep "GIT_SHA" | cut -d '=' -f2)
  if [ "$REMOTE_SHA" != "$GIT_SHA" ]; then
    _info "Downloading new version"
    _grab "https://raw.githubusercontent.com/L1so/SendWA/main/SendWA" && chmod u+x "$WA_INSTALL_DIR/sendwa.sh"
    sed "s/GIT_SHA=.*/GIT_SHA=${REMOTE_SHA}/" "${WA_INSTALL_DIR}/file.env" > "$WA_INSTALL_DIR/file.env.temp" && mv "$WA_INSTALL_DIR/file.env.temp" "$WA_INSTALL_DIR/file.env"
    _info "Success !"
  else
    _info "Already uptodate !"
  fi
else
  _info "Latest Git Hash not detected"
  exit 1
fi
