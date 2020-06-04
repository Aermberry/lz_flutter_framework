#!/usr/bin/env bash
# 用途：为当前项目添加lz-flutter git submodule
# 使用方法：./install.sh

# 此脚本遵守bash最新实践 https://kvz.io/bash-best-practices.html
set -o errexit # exit when a command fails.
# set -o pipefail # exit when any command in pipeline return non-zero code. 注释这个指令，因为HAS_SUBMODULE的grep会因为输入为空而出错
                # please reference this link https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -o nounset # exit when your script tries to use undeclared variables.
# set -o xtrace # trace what gets executed. Useful for debugging.

###
# Check preconditions
###

# Verify flutter project is a git repo
inside_git_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
if ! [ "$inside_git_repo" ]; then
  printf "Error: Not a git repository, to fix this run: git init\n"
  exit 1
fi

# Make sure this is the root of the flutter dir (search for pubspec.yaml)
if ! [ -f pubspec.yaml ]; then
  printf "Warning: Not executed in flutter root. Couldn't find pubspec.yaml.\n"
fi

printf "Installing Jenkins\n"

###
# Add lz-flutter submodule
###
LZ_FLUTTER_DIR_NAME='lz-flutter'

# Check if submodule already exists (when updating lz-flutter)
HAS_SUBMODULE=$(git submodule | grep "lz-flutter" | wc -l)
if [ $HAS_SUBMODULE -eq 0 ]; then
  printf "adding 'lz-flutter' submodule\n"
  UPDATED=false
  # add the lz-flutter submodule
  git submodule add -b master https://gitlab.liangzhicn.com/lz-flutter/lz-flutter.git $LZ_FLUTTER_DIR_NAME

  # When submodule failed, abort
  if [ ! $? -eq 0 ]; then
    echo "Abort installation of lz-flutter, couldn't clone lz-flutter" >&2
    exit 1
  fi
else
  # update url to https
  printf "Upgrading existing lz-flutter\n"
  UPDATED=true
  git submodule sync lz-flutter
fi

printf "Install lz-flutter successfully.\n"