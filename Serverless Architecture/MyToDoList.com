We want to create a mobile application with the following requirements:
  Expose as rest API with HTTPS
  Serverless architecture
  users should be able to directly interact with their own folder in S3
  Users should authenticate through a managed service
  the users can write and reads to dos but mostly read them
  The database should scale, and have some high read throughput


Mobile ---> Cognito ---> API gateway ---> Lambda ---> DAX ---> DynamoDB ---> 

Mobile ---> Cognito ---> STS ---> Mobile Client ---> S3 with permissions

------------------------------------------------------------------------------

Serverless REST API: HTTPS, API Gateway, Lambda, DynamoDB
Uses cognito to generate temp credentials with STS to access S3 bucket with restricted policy
Cahing the reads on DynamoDB using DAX
caching the REST requests at the API gateway level
Security for authentication and authorization with Cognito, STS
  
