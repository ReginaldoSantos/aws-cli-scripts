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

## Using Google as IdP and Role ARN to give app1 access to DynamoDb.
# aws sts assume-role-with-web-identity \
#     --duration-seconds 3600 \
#     --role-session-name "app1" \
#     --provider-id "www.google.com" \
#     --role-arn arn:aws:iam::504163318178:role/DynamoDB-Google-IdP \
#     --web-identity-token "Atza%7CIQEBLjAsAhRFiXuWpUXuRvQ9PZL3GMFcYevydwIUFAHZwXZXXXXXXXXJnrulxKDHwy87oGKPznh0D6bEQZTSCzyoCtL_8S07pLpr0zMbn6w1lfVZKNTBdDansFBmtGnIsIapjI6xKR02Yc_2bQ8LZbUXSGm6Ry6_BG7PrtLZtj_dfCTj92xNGed-CrKqjG7nPBjNIL016GGvuS5gSvPRUxWES3VYfm1wl7WTI7jn-Pcb6M-buCgHhFOzTQxod27L9CqnOLio7N3gZAGpsp6n1-AJBOCJckcyXe2c6uD0srOJeZlKUm2eTDVMf8IehDVI0r1QOnTV6KzzAI3OY87Vd_cVMQ"
