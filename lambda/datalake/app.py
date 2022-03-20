import json
import boto3
import csv
from datetime import datetime

def copy_file_to_datalake(source_bucket,source_key):
    destination_bucket = "vachan-datalake"
    extension = source_key.split('.')[-1]
    current_date = str(datetime.utcnow()).split(' ')[0]
    current_date = current_date.replace('-','/')
    client = boto3.client('s3')
    filename = source_key.split('/')[-1]
    destination_key = f'{extension}/{current_date}/{filename}'
    source = { 'Bucket': source_bucket,'Key': source_key }
    print("Starting Copy")
    response = client.copy_object(
        Bucket=destination_bucket,
        CopySource=f'{source_bucket}/{source_key}',
        Key=destination_key,
    )
    print("Load successful")

def lambda_handler(event, context):
    print(event)
    for event_record in event['Records']:
        body = json.loads(event_record['body'])
        print('body : ',body)
        print('message :',json.loads(body['Message']))
        for record in json.loads(body['Message'])['Records']:
            bucket = record['s3']['bucket']['name']
            key = record['s3']['object']['key']
            copy_file_to_datalake(bucket,key)  
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }


