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

# Scan table Forum: get all items
aws dynamodb scan --table-name Forum

# Query with key (HASH: mandatory for query) and comparison operator
aws dynamodb query --table-name Forum --key-conditions file://key-conditions-forum.json

# Query with key (HASH: mandatory for query), RANGE and comparison operator
aws dynamodb query --table-name Thread --key-conditions file://key-conditions-thread.json

# Query with local secondary index to evaluate projections: keys only
aws dynamodb query --table-name Reply \
--index-name PostedBy-Message-Index \
--key-condition-expression "Id = :v_id and PostedBy = :v_user" \
--expression-attribute-values  '{":v_id":{"S":"Amazon DynamoDB#DynamoDB Thread 1"},":v_user":{"S":"User A"} }'
