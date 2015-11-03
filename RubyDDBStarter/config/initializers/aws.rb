require 'aws-sdk'

Aws.config.update ({
region: 'us-east-1',
credentials: Aws::SharedCredentials.new})
