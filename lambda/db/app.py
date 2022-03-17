import json
import pandas as pd

def save_data_dynamodb(bucket,key):
    s3_uri = f's3://{bucket}/{key}'
    print('s3_uri',s3_uri)
    df = pd.read_csv(s3_uri)
    print('Boop')
    print('printing record : ',df['Gender'].iloc[0])
    print(df)
    print('Blip')
    
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


