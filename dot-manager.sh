#!/bin/sh
#
# Dot Manager - Manages dotfiles
#
# @rev     0.1.0
# @update  2014-1-18
# @author  Saneyuki Tadokoro <saneyan@mail.gfunction.com>
# @license MIT License

#
# Configuration
#
_dirname="$(dirname ${0})"
DOTIGNORE="${_dirname}/config/dotignore"
DOTTYPE="${_dirname}/config/dottype"
DOTFILE_DIR="${_dirname}/dotfiles"

#
# Heredocs
#
_dom_help_heredoc="
 - Dot Manager

Usage: dom <command> [option]

Commands:
  link   : Make symbolic links of dotfile
  update : Update remote or local repository of dotfiles
  type   : Change dotfile type

Options:
  -l | --list-files : List available dotfiles
  -h | --help       : Show help
"

_link_help_heredoc="
 - Dot Manager (link command)

Usage: link [option]

Options:
  -m | --make-sym-links : Make symbolic links of dotfiles
  -M | --make-sym-link  : Make a symbolic link of a dotfile
  -h | --help           : Show help
"

_update_help_heredoc="
 - Dot Manager (update command)

Usage: update [option]

update options:
  -l | --pull : Pull repository
  -u | --push : Push commits of repository
  -h | --help : Show help
"

_type_help_heredoc="
 - Dot Manager (type command)

Usage: type [option]

type options:
  -c | --change : Change dotfile type
  -s | --show   : Show current type
  -h | --help   : Show help
"

_dom_err_heredoc="
Usage: dom --help
  for help
"

_link_err_heredoc="
Usage: link --help
  for help
"

_update_err_heredoc="
Usage: update --help
  for help
"

_type_err_heredoc="
Usage: type --help
  for help
"

#
# Get acceptance
#
function _get_acceptance() {
  local ans=

  while true
  do
    echo -n "Would you like to make symbolic link? [y/n]: "
    read ans

    case $ans in
      [Yy]) return 0 ;;
      [Nn]) return 1 ;;
      *) echo "Type 'y' for yes or 'n' for no." ;;
    esac
  done
}

#
# Check if specific element of array exists
#
function _search() {
  test
}

#
# Get ignores
#
function _get_ignores() {
  local t=

  if [ ! -e $DOTTYPE ]; then
    t=""
  else
    t=$(cat ${DOTTYPE})
  fi

  if [ ! -e $DOTIGNORE ]; then
    _ignores=""
  else
    _ignores=$(cat ${DOTIGNORE})
  fi
}

#
# Make symbolic links
#
function _mk_sym_links() {
  _get_acceptance

  if [ $? -eq 1 ]; then
    echo "Aborted."
    return 1
  fi

  _get_ignores

  local dotfiles=($(ls))

  for i in ${dotfiles}
  do
    _search $_ignores $i

    if [ $? -ne 0 ]; then
      echo ".${i}"
    fi
  done
}

#
# Make a symbolic link
#
function _mk_sym_link() {
  local target="${DOTFILE_DIR}/$1"

  if [ ! -e $target ]; then
    echo "No target found: ${target}"
    return 1
  fi

  _get_ignores

  _search $_ignores $1

  if [ $? -ne 0 ]; then
    echo ".${1}"
  fi
  #ln -s $target "${HOME}/.$1"
}

#
# List dotfiles
#
function _list_files() {
  test
}

#
# Pull updates
#
function _pull() {
  test
}

#
# Push commits
#
function _push() {
  test
}

#
# Change dotfile type
#
function _change() {
  ${DOTTYPE} < $1
}

#
# Show current type
#
function _show() {
  if [ ! -e $DOTTYPE ]; then
    echo "No dotfile type specified."
    return 1
  else
    cat ${DOTTYPE}
  fi
}

#
# Sub commands
#
function _link() {
  case $1 in
    "-m"|"--make-sym-links")
      _mk_sym_links
      break
      ;;
    "-M"|"--make-sym-link")
      _mk_sym_link $2
      break
      ;;
    "-h"|"--help")
      echo "${_link_help_heredoc}"
      break
      ;;
    *)
      echo "${_link_err_heredoc}" 1>&2
      return 1
      ;;
  esac
}

function _update() {
  case $1 in
    "-u"|"--push")
      _push
      break
      ;;
    "-l"|"--pull")
      _pull
      break
      ;;
    "-h"|"--help")
      echo "${_update_help_heredoc}"
      break
      ;;
    *)
      echo "${_update_err_heredoc}" 1>&2
      return 1
      ;;
  esac
}

function _type() {
  case $1 in
    "-c"|"--change")
      _change $2
      break
      ;;
    "-s"|"--show")
      _show
      break
      ;;
    "-h"|"--help")
      echo "${_type_help_heredoc}"
      break
      ;;
    *)
      echo "${_type_err_heredoc}" 1>&2
      return 1
      ;;
  esac
}

#
# Get arguments of command line
#
case $1 in
  "link")
    _link ${@:2}
    break
    ;;
  "update")
    _update ${@:2}
    break
    ;;
  "type")
    _type ${@:2}
    break
    ;;
  "-l"|"--list-files")
    _list_files
    break
    ;;
  "-h"|"--help")
    echo "${_dom_help_heredoc}"
    break
    ;;
  *)
    echo "${_dom_err_heredoc}" 1>&2
    exit 1
    ;;
esac

if [ $? -eq 1 ]; then
  echo "Error reported."
  exit 1
fi

exit 0
