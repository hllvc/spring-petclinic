#!/bin/bash

# update
pacman -Syyu --noconfirm

# check if jdk and jre exists, if not download
if ! pacman -Qs jdk-openjdk > /dev/null && ! pacman -Qs jre-openjdk; then
	pacman -S jdk-openjdk jre-openjdk --noconfirm
fi

# check if cloned dir exists
if [[ ! -d spring-petclinic ]]; then
	# install necessary packages
	pacman -S git base base-devel --noconfirm
	# clone repository
	git clone https://github.com/spring-projects/spring-petclinic.git
	cd spring-petclinic
else
	# cd into spring-petclinic and pull updates
	cd spring-petclinic
	git pull origin main
fi

if [[ -d target  ]]; then
	# remove old target dir
	rm -rf target
fi

# compile spring-petclinic
./mvnw package

# run compiled app
java -jar target/*.jar
