import json
import boto3
import csv
from datetime import datetime

def copy_file_to_datalake(source_bucket,source_key):
    destination_bucket = "vachan-datalake-demo"
    extension = source_key.split('.')[-1]
    current_date = str(datetime.utcnow())
    client = boto3.client('s3')
    destination_key = f'{extension}/{current_date}/{source_key}'
    source = { 'Bucket': source_bucket,'Key': source_key }
    print("Starting Copy")
    response = client.copy_object(
        Bucket=destination_bucket,
        CopySource=f'{source_bucket}/{source_bucket}',
        Key=destination_key,
    )
    print("Load successful")

def lambda_handler(event, context):
    print(event)
    for event_record in event['Records']:
        body = json.loads(event_record['body'])
        for record in json.loads(body['Message'])['Records']:
            bucket = record['s3']['bucket']['name']
            key = record['s3']['object']['key']
            copy_file_to_datalake(bucket,key)  
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }


