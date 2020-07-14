#!/bin/bash

########################################################################
#
# Using AWS CLI commands to create tables and play around with DynamoDB
#
########################################################################

## Setting AWS Region => both ways work!

#export AWS_REGION=us-east-2
aws configure set region us-east-2

# ProductCatalog = {
#       TableName: 'ProductCatalog',
#       KeySchema: [ 
#           { 
#               AttributeName: 'Id', KeyType: 'HASH'
#           }
#       ],
#       AttributeDefinitions: [ 
#           {   AttributeName: 'Id', AttributeType: 'N' }
#       ],
#       ProvisionedThroughput: { 
#           ReadCapacityUnits: 1, 
#           WriteCapacityUnits: 1, 
#       }
#   };


aws dynamodb create-table \
              --table-name ProductCatalog \
              --attribute-definitions AttributeName=Id,AttributeType=N \
              --key-schema AttributeName=Id,KeyType=HASH \
              --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1

# Forum = {
#       TableName: 'Forum',
#       KeySchema: [ 
#           { 
#               AttributeName: 'Name', KeyType: 'HASH'
#           }
#       ],
#       AttributeDefinitions: [ 
#           {   AttributeName: 'Name', AttributeType: 'S' }
#       ],
#       ProvisionedThroughput: { 
#           ReadCapacityUnits: 1, 
#           WriteCapacityUnits: 1, 
#       }
#   };

aws dynamodb create-table \
              --table-name Forum \
              --attribute-definitions AttributeName=Name,AttributeType=S \
              --key-schema AttributeName=Name,KeyType=HASH \
              --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1

# Thread = {
#       TableName: 'Thread',
#       KeySchema: [ 
#           { 
#               AttributeName: 'ForumName', KeyType: 'HASH'
#           },
#           { 
#               AttributeName: 'Subject', KeyType: 'RANGE', 
#           }
#       ],
#       AttributeDefinitions: [ 
#           {   AttributeName: 'ForumName', AttributeType: 'S' },
#           {   AttributeName: 'Subject', AttributeType: 'S' },
#       ],
#       ProvisionedThroughput: { 
#           ReadCapacityUnits: 1, 
#           WriteCapacityUnits: 1, 
#       }
#   };

aws dynamodb create-table \
              --table-name Thread \
              --attribute-definitions AttributeName=ForumName,AttributeType=S AttributeName=Subject,AttributeType=S \
              --key-schema AttributeName=ForumName,KeyType=HASH AttributeName=Subject,KeyType=RANGE \
              --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1

# Reply = {
#       TableName: 'Reply',
#       KeySchema: [ 
#           { 
#               AttributeName: 'Id', KeyType: 'HASH'
#           },
#           { 
#               AttributeName: 'ReplyDateTime', KeyType: 'RANGE', 
#           }
#       ],
#       AttributeDefinitions: [ 
#           {   AttributeName: 'Id', AttributeType: 'S' },
#           {   AttributeName: 'ReplyDateTime', AttributeType: 'S' },
#           {   AttributeName: 'PostedBy', AttributeType: 'S' }
# 
#       ],
#       ProvisionedThroughput: { 
#           ReadCapacityUnits: 1, 
#           WriteCapacityUnits: 1, 
#       },
#       LocalSecondaryIndexes: [ 
#           { 
#               IndexName: 'PostedBy-Message-Index', 
#               KeySchema: [
#                   {   AttributeName: 'Id', KeyType: 'HASH' },
#                   {   AttributeName: 'PostedBy', KeyType: 'RANGE' }
#               ],
#               Projection: { 
#                   ProjectionType: 'KEYS_ONLY' 
#               }
#           }
#       ]
#   };

aws dynamodb create-table \
              --table-name Reply \
              --attribute-definitions AttributeName=Id,AttributeType=S AttributeName=ReplyDateTime,AttributeType=S AttributeName=PostedBy,AttributeType=S \
              --key-schema AttributeName=Id,KeyType=HASH AttributeName=ReplyDateTime,KeyType=RANGE \
              --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
              --local-secondary-indexes IndexName=PostedBy-Message-Index,KeySchema=["{AttributeName=Id,KeyType=HASH},{AttributeName=PostedBy,KeyType=RANGE}"],Projection={ProjectionType=KEYS_ONLY}

aws dynamodb list-tables
