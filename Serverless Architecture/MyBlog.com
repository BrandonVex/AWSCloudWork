This should scale globally ---> 
Blogs are rarely written, but often read --->
some of the website is purely static files, the reswt is a Dynamic REST API --->
caching must be implemented where possible ---> 
Any new users that subscribe should recieve an email --->
Any photo uploaded to the blog should have a thumbnail generated --->

----------------------------------------------

Client ---> Amazon Cloudfront ---> S3 (caching static)
Client ---> Amazon Cloudfront ---> OAC ---> S3 With Policy (Secure caching static)
Client ---> API gateway ---> LAMBDA ---> Dax ---> DynamoDB (REST API)
Client ---> API gateway ---> LAMBDA ---> Dax ---> DynamoDB Global Tables (Global REST API)
Client ---> API gateway ---> LAMBDA ---> Dax ---> DynamoDB ---> DynamoDB Stream ---> LAMBDA with IAM role ---> SES  (Welcome Email Flow)
Client ---> Amazon Cloudfront ---> OAC ---> S3 ---> LAMBDA ---> S3 ---> SQS AND SNS (Thumbnail)

================================================================================================

We've seen static content being distributed using CloudFront with S3
The REST API was serverless, didnt need Cognito because public
we leveraged DynamoDB table to serve the data globally
We enabled DynamoDB streams to trigger a Lambda function
The lambda function had an IAM role which uses SES
SES = Simple Email Service
S3 can trigger SQS / SNS / LAMBDA / To notify event
