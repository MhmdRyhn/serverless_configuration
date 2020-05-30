import json


def lambda_handler(event, context):
    response = {
        "statusCode": 200,
        "body": json.dumps({
            "name": "Rayhan",
            "event": event
        })
    }
    return response
