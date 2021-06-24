#!/bin/sh

# update
pacman -Syyu --noconfirm

# check if cloned dir exists
if [[ ! -d spring-petclinic ]]; then
	# install necessary packages
	pacman -S git base base-devel --noconfirm
	# clone repository
	git clone https://github.com/spring-projects/spring-petclinic.git
fi

cd spring-petclinic

if [[ ! -d target  ]]; then
	# download jdk and jre
	pacman -S jdk-openjdk jre-openjdk --noconfirm
	# compile spring-petclinic
	./mvnw package
fi

# run compiled app
java -jar target/*.jar
