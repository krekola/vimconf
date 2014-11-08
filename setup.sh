#!/bin/bash

cd ~/.vim

mkdir -p autoload bundle

if [ ! -e autoload/pathogen.vim ]; then
  echo "Downloading Pathogen"
  curl -LSso autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

cd bundle
while read repo_url; do
  echo "############## downloading $repo_url ##################"
  git clone $repo_url
done <../default_repos
cd ..

cat default_vimrc > ~/.vimrc
