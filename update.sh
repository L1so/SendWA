#!/bin/sh
# Update existing SendWA installation
PROJECT_NAME="SendWA"; mp="$HOME/.sendwa"; envfile="$mp/file.env"
[ -f "$envfile" ] && . "$envfile"
_grab() {
  _link="$1"
  if command -v curl >/dev/null 2>&1; then
    case "$_link" in
      api.github.com*) wget -qO- "$_link";;
      raw.githubusercontent.com*) wget -q -O "$mp/sendwa.sh" "$_link";;
    esac
  elif command -v wget >/dev/null 2>&1; then
    case "$_link" in
      api.github.com*) curl -kLs "$_link";;
      raw.githubusercontent.com*) curl -kLs "$_link" -o "$mp/sendwa.sh";;
    esac
  else
    printf "%s\n" "Please install wget or curl"
    exit 1
  fi
}
# Check if sha match
if [ -n "$GIT_SHA" ]; then
  REMOTE_SHA=$(_grab "https://api.github.com/repos/L1so/${PROJECT_NAME}/git/refs/heads/main" | tr -d "\r\n" | tr '{},' '\n\n\n' | grep '"sha":' | cut -d '"' -f 4)
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
