#!/usr/bin/env bash

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

function success() {
	printf "%b%s%b" "${GREEN}" "${1}" "${NC}\n"
}

function warning() {
	printf "%b%s%b" "${YELLOW}" "${1}" "${NC}\n"
}

function error() {
	printf "%b%s%b" "${RED}" "${1}" "${NC}\n"
}

if [ "$#" == 0 ]; then
	error "Incorrect amount of arguments"
	echo "Usage: gcl <git_repository_url>"

	exit 1
fi

BASE_PATH="/Users/pavlo.nikulin/development"
GIT_REPO_URL=$1

[[ $GIT_REPO_URL =~ ^(https:\/\/|git@)([^:/]+)[:/](.+)/ ]] && GIT_REPO_RELATIVE_PATH="${BASH_REMATCH[2]}/${BASH_REMATCH[3]}"
GIT_REPO_RELATIVE_PATH="${GIT_REPO_RELATIVE_PATH//:/\/}"

GIT_REPO_RELATIVE_PATH="${GIT_REPO_RELATIVE_PATH//:/\/}"
[[ $GIT_REPO_URL =~ /([^/]+)(\.git)?$ ]] && GIT_REPO_NAME="${BASH_REMATCH[1]%.git}"

GIT_REPO_ABSOLUTE_PATH="$BASE_PATH/${GIT_REPO_RELATIVE_PATH}"

GIT_REPO_FULL_PATH="$GIT_REPO_ABSOLUTE_PATH/${GIT_REPO_NAME}"

if [ -d "$GIT_REPO_ABSOLUTE_PATH" ]; then
	warning "Directory already exists"
else
	mkdir -p "$GIT_REPO_ABSOLUTE_PATH"

	success "Succesfully created directory: $GIT_REPO_ABSOLUTE_PATH"
fi

if [ -d "$GIT_REPO_ABSOLUTE_PATH/${GIT_REPO_NAME}" ]; then
	error "Repository already exists" && exit 1
fi

cd "$GIT_REPO_ABSOLUTE_PATH" || return
git clone "$GIT_REPO_URL" "$GIT_REPO_FULL_PATH" -t /Users/pavlo.nikulin/.git_template
if [ $? -ne 0 ]; then
	error "Failed to clone repository"
	exit 1
fi

success "Succesfully cloned repository"

success "$GIT_REPO_ABSOLUTE_PATH/${GIT_REPO_NAME}"
