#!/bin/sh
# Update existing SendWA installation
PROJECT_NAME="SendWA"; mp="$HOME/.sendwa"; envfile="$mp/file.env"
[ -f "$envfile" ] && . "$envfile"
_info() {
  printf "%s\n" "$(date +"[%d %b %Y %l:%M:%S %p %Z]") $*"
}
_grab() {
  _link="$1"
  if command -v curl >/dev/null 2>&1; then
    case "$_link" in
      *file.env) wget -qO- "$_link";;
      *SendWA) wget -q -O "$mp/sendwa.sh" "$_link";;
    esac
  elif command -v wget >/dev/null 2>&1; then
    case "$_link" in
      *file.env) curl -kLs "$_link";;
      *SendWA) curl -kLs "$_link" -o "$mp/sendwa.sh";;
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
    _grab "https://raw.githubusercontent.com/L1so/SendWA/main/SendWA" && chmod u+x "$mp/sendwa.sh"
    sed "s/GIT_SHA=.*/GIT_SHA=${REMOTE_SHA}/" "${mp}/file.env" > "$mp/file.env.temp" && mv "$mp/file.env.temp" "$mp/file.env"
    _info "Success !"
  else
    _info "Already uptodate !"
  fi
else
  _info "Latest Git Hash not detected"
  exit 1
fi
