# CI/CD Frontend
I am setting up my #Cloudresume CI/CD frontend with the help of the below `action`.
This action automates the upload of front end files to my S3 bucket. Please visit my [website](https://www.komlalebu.com) for more information.

# Action
[jakejarvis/s3-sync-action@master](https://github.com/jakejarvis/s3-sync-action)

# Purpose
1. Automate uploads of my repository files to my S3 bucket (which is hosting my static website) on every commit and push.
2. AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY have been passed as environment variables for security purposes.
   
# Usage - main.yml
                name: Upload Website

                on:
                  push:
                    branches:
                    - master

                jobs:
                  deploy:
                    runs-on: ubuntu-latest
                    steps:
                    - uses: actions/checkout@master
                    - uses: jakejarvis/s3-sync-action@master
                      with:
                        args: --acl public-read --follow-symlinks  --exclude '.git*/*' 
                      env:
                        AWS_S3_BUCKET: ${{ secrets.AWS_S3_BUCKET }}
                        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
                        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
                        AWS_REGION: 'ap-south-1'