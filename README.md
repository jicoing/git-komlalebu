# CI/CD Frontend
I am setting up my #Cloudresume CI/CD frontend with the help of the below `action`.
This action automates the upload of front end files to my S3 bucket. Please visit my [website](https://www.komlalebu.com) for more information.

# Action
[jakejarvis/s3-sync-action@master](https://github.com/jakejarvis/s3-sync-action)

# Purpose
1. Automate uploads of my repository files to my S3 bucket (which is hosting my static website) on every commit and push.
2. AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY should be passed as environment variables for security purposes.
   
