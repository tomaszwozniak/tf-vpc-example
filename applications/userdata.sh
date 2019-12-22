#!/bin/bash -v
# Since there is no internet access and VPC endpoint that won' be sucessfully executed but leaving as an example
apt-get update -y
apt-get install -y nginx > /tmp/nginx.log
