#!/bin/bash

FROM ubuntu:14.10

MAINTAINER Udaya Narayanachar 

# Update the repository sources list
RUN apt-get update

################## BEGIN INSTALLATION ######################

# Install project dependencies
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN apt-get install -y unzip
RUN apt-get install dos2unix

# Install MySQL Server
RUN apt-get install -y debconf-utils
RUN echo 'mysql-server mysql-server/root_password password root' | sudo debconf-set-selections 
RUN echo 'mysql-server mysql-server/root_password_again password root' | sudo debconf-set-selections 
RUN apt-get install -y mysql-server

# Install MondoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
RUN apt-get update
RUN apt-get install mongodb-10gen

# Install PostgresSQL
RUN apt-get update
RUN apt-get install -y postgresql postgresql-contrib


# Install Oracle Java 7
RUN mkdir /mnt/javatempdircopy
RUN cd /mnt/javatempdircopy
RUN wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u5-b13/jdk-8u5-linux-x64.tar.gz
RUN mkdir /opt/jdk
RUN tar -zxvf jdk-8u5-linux-x64.tar.gz -C /opt/jdk
RUN update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_05/bin/java 100
RUN update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_05/bin/javac 100
RUN update-alternatives --display java
RUN update-alternatives --display javac

# Install MuleESB server 
RUN mkdir /mnt/tempdircopy
RUN wget http://ec2-54-204-218-30.compute-1.amazonaws.com:8080/examples/servlets/dockerconfigfiles/mule-standalone-3.5.0.tar.gz -O /mnt/tempdircopy/mule-standalone-3.5.0.tar.gz
RUN mkdir /mnt/muleesbserver
RUN tar -zxvf /mnt/tempdircopy/mule-standalone-3.5.0.tar.gz -C /mnt/muleesbserver


RUN mkdir /mnt/script
RUN wget http://ec2-54-204-218-30.compute-1.amazonaws.com:8080/examples/servlets/dockerconfigfiles/run.sh -O /mnt/script/run.sh
RUN dos2unix /mnt/script/run.sh

##################### INSTALLATION END #####################

 

 
