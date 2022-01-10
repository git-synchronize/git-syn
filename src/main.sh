#!/bin/sh
# A command line extension for synchronizing git remote repositories
# SPDX-License-Identifier: GPL-2.0-or-later
set -eu

VERSION="0.0.1"

# Default options
debug=0
verbose=0
quiet=0
repository="."

usage() {
  cat <<EOF
Usage: git-syn [option] ... [repository] ...

Options:
  -h, --help            Show this message and quit
  -d, --debug           Output debugging messages
  -q, --quiet           Only output fatal error messages
  -v, --verbose         Be verbose (show external command output)
  --version             Print version and exit

Arguments:
  repository            Path to a git repository
EOF
}

get_remotes_file() {
  dir=$1

  remotes_file=$(find "${dir}" -name ".gitremotes")

  echo "${remotes_file}"
}

get_remotes () {
  remotes_file=$1

  remotes=$(awk '/remote/ { gsub(/\[|\]/, ""); print $2 }' "${remotes_file}" | sed 's/"//g')

  echo "${remotes}"
}

enumerate_remotes() {
  remotes_file=$1

  number_of_remotes=$(get_remotes "${remotes_file}" | wc -l)

  echo "${number_of_remotes}"
}

synchronize_remotes() {
  remotes_file=$1
  remotes=$2
  debug=$3
  verbose=$4
  quiet=$5

  if [ "${debug}" = 1 ]; then
    echo "synchronize_remotes: number of remotes is ${number_of_remotes}"
  fi

  # Fetch latest from remotes

  if [ "${quiet}" = 1 ]; then
    git fetch --all &> /dev/null
    git pull origin master &> /dev/null
  else
    git fetch --all
    git pull origin master
  fi

  # Push latest to remotes

  for remote in $remotes; do
    if [ "${quiet}" = 1 ]; then
      git push --all $remote &> /dev/null
    else
      git push --all $remote
    fi
  done
}

main() {
  # Parse command-line arguments

  while [ ${#} -gt 0 ]
  do
    argument=${1}
    shift
    case "${argument}" in
      -h|--help)
        usage
        exit 0
        ;;
      -d|--debug)
        debug=1
        ;;
      -q|--quiet)
        if [ "${verbose}" = 1 ]; then
          echo "The --quiet and --verbose options are mutually exclusive"
          exit 1
        fi
        quiet=1
        ;;
      -v|--verbose)
        if [ "${quiet}" = 1 ]; then
          echo "The --quiet and --verbose options are mutually exclusive"
          exit 1
        fi
        verbose=1
        ;;
      --version)
        echo "git-syn version ${VERSION}"
        exit 0
        ;;
      -*)
        echo "You have specified an invalid option: ${argument}"
        exit 1
        ;;
      *)
        repository="${argument}"
        ;;
    esac
  done

  if [ "${debug}" = 1 ]; then
    echo "debug is ${debug}"
    echo "verbose is ${verbose}"
    echo "quiet is ${quiet}"
  fi

  if [ "${verbose}" = 1 ]; then
    echo "repository is ${repository}"
  fi

  remotes_file=$(get_remotes_file "${repository}")
  remotes=$(get_remotes "${remotes_file}")
  number_of_remotes=$(enumerate_remotes "${remotes_file}")

  if [ "${debug}" = 1 ]; then
    echo "main: number of remotes is ${number_of_remotes}"
  fi

  synchronize_remotes "${remotes_file}" "${remotes}" "${debug}" "${verbose}" "${quiet}"
}

if [ "$(basename "${0}")" = "git-syn" ]; then
  main "${@}"
fi

