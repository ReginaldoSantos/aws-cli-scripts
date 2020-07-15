#!/bin/bash

######################################################################
#
# Using AWS CLI commands to fill in tables with Json source
#
######################################################################

## Setting AWS Region => both ways work!

#export AWS_REGION=us-east-2
aws configure set region us-east-2

aws dynamodb batch-write-item --request-items file://ProductCatalog.json

aws dynamodb batch-write-item --request-items file://Forum.json

aws dynamodb batch-write-item --request-items file://Thread.json

aws dynamodb batch-write-item --request-items file://Reply.json
