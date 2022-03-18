import json
import boto3
import csv

def save_data_dynamodb(bucket,key):
    s3_uri = f's3://{bucket}/{key}'
    print('s3_uri',s3_uri)
    s3_resource = boto3.resource('s3')
    s3_object = s3_resource.Object(bucket, key)
    data = s3_object.get()['Body'].read().decode('utf-8').splitlines()
    lines = csv.reader(data)
    headers = next(lines)
    print('headers: %s' %(headers))
    for line in lines:
        print(line)
    
def lambda_handler(event, context):
    print(event)
    for event_record in event['Records']:
        body = json.loads(event_record['body'])
        for record in json.loads(body['Message'])['Records']:
            bucket = record['s3']['bucket']['name']
            key = record['s3']['object']['key']
            save_data_dynamodb(bucket,key)    
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }


