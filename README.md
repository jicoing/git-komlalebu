![Alt Text](https://s3.amazonaws.com/blog.komlalebu.com/hilltop.PNG)
# CI/CD Frontend
I am setting up my #Cloudresume CI/CD frontend with the help of the below `action`.
This action automates the upload of front end files to my S3 bucket. Please visit [bio](http://blog.komlalebu.com/) for more information.

# Action
Uploads the website source code to my S3 bucket and also invalidates the Cloudfront cache after upload.

# Purpose
1. Automate uploads of my repository files to my S3 bucket (which is hosting my static website) on every commit and push.
2. AWS_ACCESS_KEY_ID, AWS_S3_BUCKET, DISTRIBUTION_ID and AWS_SECRET_ACCESS_KEY have been passed as environment variables for security purposes.
3. I modified the entrypoint.sh slightly and added the below script for invalidating cloudfront cache for my distribution.
               
               sh -c "aws cloudfront create-invalidation --distribution-id ${DISTRIBUTION_ID} --paths "/*" --profile s3-sync-action"

   
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
                    - uses: ./.github/actions/sam/package
                      with:
                        args: --acl public-read --follow-symlinks  --exclude '.git*/*' 
                      env:
                        AWS_S3_BUCKET: ${{ secrets.AWS_S3_BUCKET }}
                        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
                        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
                        DISTRIBUTION_ID: ${{ secrets.DISTRIBUTION_ID }}
                        AWS_REGION: 'ap-south-1'
