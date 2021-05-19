#!/bin/bash
echo "--------------START SCRIPT-------------------"
sudo yum -y update
echo "--------------INSTALL RUBY-------------------"
sudo yum install -y ruby
echo "--------------END UPDATES-------------------"
cd /home/ec2-user
echo "--------------CURL-------------------"
curl -O https://aws-codedeploy-eu-west-1.s3.amazonaws.com/latest/install
echo "--------------CHMOD-------------------"
sudo chmod +x ./install
sudo ./install auto
echo "--------------STOP SCRIPT-------------------"