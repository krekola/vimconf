#!/bin/bash
pushd ~/.vim > /dev/null

###############################################################################
#### stage1

if [ "$1" != "-stage2" ]; then
  echo "############## fetch & pull krekola/vimconf"
  git fetch && git pull
  ./setup.sh -stage2
  exit 0
fi

###############################################################################
### stage2

mkdir -p autoload bundle

if [ ! -e autoload/pathogen.vim ]; then
  echo "Downloading Pathogen"
  curl -LSso autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

pushd bundle > /dev/null
while read repo_url; do
  REPOFOLDER=$(echo $repo_url | awk -F'/' '{print $NF}' | sed "s/\.git//g")
  if [ -d "${REPOFOLDER}" ]; then
    echo "############## fetch & pull $repo_url"
	pushd ${REPOFOLDER} > /dev/null
	git fetch && git pull
	popd > /dev/null
  else
    echo "############## clone $repo_url"
    git clone $repo_url
  fi
done <../default_repos
popd > /dev/null

echo "############## reset .vimrc to defaults"
cat default_vimrc > ~/.vimrc
popd > /dev/null

