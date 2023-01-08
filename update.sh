#!/bin/sh
# Update existing SendWA installation
PROJECT_NAME="SendWA"; mp="$HOME/.sendwa"; envfile="$mp/file.env"
[ -f "$envfile" ] && . "$envfile"
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
    printf "%s\n" "Please install wget or curl"
    exit 1
  fi
}
# Check if sha match
if [ -n "$GIT_SHA" ]; then
  REMOTE_SHA=$(_grab "https://raw.githubusercontent.com/L1so/SendWA/main/file.env" | grep "GIT_SHA" | cut -d '=' -f2)
  if [ "$REMOTE_SHA" != "$GIT_SHA" ]; then
    printf "%s\n" "Downloading new version"
    _grab "https://raw.githubusercontent.com/L1so/SendWA/main/SendWA" && chmod u+x "$mp/sendwa.sh"
    printf "%s\n" "Success !"
  else
    printf "%s\n" "Already uptodate !"
  fi
else
  printf "%s\n" "Latest Git Hash not detected"
  exit 1
fi
