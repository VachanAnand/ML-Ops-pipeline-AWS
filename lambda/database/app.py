import json
import boto3
import csv


def put_record_dynamodb(line):
    record = {
        'UserId': line[0],
        'FirstName': line[1],
        'LastName': line[2],
        'Email': line[3],
        'Gender': line[4],
        'Age': line[5]
    }
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('vachan-dynamo-users-demo')
    response = table.put_item(
        Item=record
        )
    print('Record added successfully')

def save_data_dynamodb(bucket,key):
    s3_uri = f's3://{bucket}/{key}'
    print('s3_uri',s3_uri)
    s3_resource = boto3.resource('s3')
    s3_object = s3_resource.Object(bucket, key)
    data = s3_object.get()['Body'].read().decode('utf-8').splitlines()
    lines = csv.reader(data)
    for line in lines:
        print(line)
        put_record_dynamodb(line)
    
def lambda_handler(event, context):
    print(event)
    for event_record in event['Records']:
        body = json.loads(event_record['body'])
        for record in json.loads(body['Message'])['Records']:
            bucket = record['s3']['bucket']['name']
            key = record['s3']['object']['key']
            if 'users.csv' in key:
                save_data_dynamodb(bucket,key)  
            else:
                print('Not CSV')  
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }