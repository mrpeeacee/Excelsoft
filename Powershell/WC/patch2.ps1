# Check for available updates
Install-Module -Name PSWindowsUpdate -Force
Import-Module -Name PSWindowsUpdate
$updates = Get-WindowsUpdate -Category "Security Updates" -Confirm:$false

# Check if there are any available updates
if ($updates.Count -eq 0) {
    Write-Host "No updates available"
    return
}

# Install the available updates
Write-Host "Installing updates..."
$updates | Install-WindowsUpdate -AcceptAll -AutoReboot

# Check for available updates again
$updates = Get-WindowsUpdate -Category "Security Updates"

# Check if there are any available updates after the installation
if ($updates.Count -eq 0) {
    Write-Host "Updates installed successfully"
} else {
    Write-Host "Updates still available after installation"
}


---------------------------


schemaVersion: 1.0
description: EC2 Image Builder pipeline with S3 input source
parameters:
  s3Bucket: {
    type: String
    default: cicdv1
    description: Name of the S3 bucket containing the input object
  }
  s3KeyPrefix:
    type: String
    default: packages
    description: Prefix for the S3 key of the input object
  instanceType:
    type: String
    default: t2.micro
    description: Instance type for the EC2 instance used for building the image
phases:
  - name: build
    steps:
      - name: MyComponentStep
        action:
          type: execute-component
          componentArn: arn:aws:imagebuilder:ap-south-1:526402039025:component/S3Component/1.0.0
          inputArtifacts:
            - name: MyInputArtifact
              s3Location:
                bucketName: !Ref s3Bucket
                objectKey: !Sub "${s3KeyPrefix}/*.zip"
          outputs:
            - name: MyOutputArtifact
              artifactDescription: My output artifact
components:
  - name: MyComponent
    description: My S3 input component
    version: 1.0.0
    platform: Windows
    data:
      sources:
        - name: MySource
          uri: s3://{{s3Bucket}}/{{s3KeyPrefix}}/*.zip
      blocks:
        - name: MyBlock
          access:
            logging: false
