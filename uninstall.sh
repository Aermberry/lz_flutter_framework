#!/usr/bin/env bash
# 用途：删除当前项目的lz-flutter submodule
# 使用方法：./uninstall.sh

# 此脚本遵守bash最新实践 https://kvz.io/bash-best-practices.html
set -o errexit # exit when a command fails.
set -o pipefail # exit when any command in pipeline return non-zero code. 
                # please reference this link https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -o nounset # exit when your script tries to use undeclared variables.
# set -o xtrace # trace what gets executed. Useful for debugging.

echo "Uninstalling lz-flutter ..."

LZ_FLUTTER_DIR_NAME='lz-flutter'

# remove submodule
git submodule deinit -f $LZ_FLUTTER_DIR_NAME

# remove submodule directory
git rm -rf $LZ_FLUTTER_DIR_NAME

# remove submodule history
rm -rf .git/modules/$LZ_FLUTTER_DIR_NAME

# remove empty .gitmodules file
if ! [ -s .gitmodules ]; then
  # try via git first, fallback to just rm when not added to git
  git rm -f .gitmodules >>/dev/null 2>&1 || rm .gitmodules
fi