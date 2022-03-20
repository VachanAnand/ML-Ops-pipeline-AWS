import json
import boto3
import csv
from datetime import datetime

def copy_file_to_datalake(source_bucket,source_key):
    destination_bucket = "vachan-data-pipeline-landing"
    source_trigger = "amplify"
    extension = source_key.split('.')[-1]
    current_date = str(datetime.utcnow()).split(' ')[0]
    current_date = current_date.replace('-','/')
    client = boto3.client('s3')
    filename = source_key.split('/')[-1]
    destination_key = f'{source_trigger}/{filename}'
    print("Starting Copy")
    print("source_bucket",source_bucket)
    print("source_key",source_key)
    response = client.copy_object(
        Bucket=destination_bucket,
        CopySource=f'{source_bucket}/{source_key}',
        Key=destination_key,
    )
    print("Load successful")


def lambda_handler(event, context):
    print("hey")
    print(event)
    for record in event['Records']:
        print("record",record)
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
        # symbol ':' get encoded as %3A
        key = key.replace('ap-southeast-2%3A','ap-southeast-2:')
        copy_file_to_datalake(bucket,key)
