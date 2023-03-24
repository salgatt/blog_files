import json
import logging
import requests

def lambda_handler(event, context):
    # TODO implement
    try:
        logging.debug("success")
        rest_api = 'https://reqres.in/api/users/2'
        x = requests.get(rest_api)
        return {"statusCode": x.status_code, "body": json.dumps(x.json())}
    except Exception as e:
        logging.error(e)
        return {"statusCode": 400,"body": json.dumps({"status":"failed", "message":"failed to process request","detail":str(e)})}