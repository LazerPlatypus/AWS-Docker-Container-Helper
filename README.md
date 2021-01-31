# AWS Lambda Docker Container Helper
 A cli helper for windows

 Requirements:
 
  AWS CLI tool. can be downloaded from amazon
  
  AWS credentials set. after downloading & installing the AWS CLI tool run 'aws configure' from the CLI and input credentials there
  Amazon has a help document for configuring the AWS CLI tool. look it up if you're having issues

 Description:
 
  When deploying AWS Lambda Docker containers to AWS from the CLI, you end up using the same commands over and over again
  this tool creates several bat files when provided your AWS account number and region
  
  Add the folder these commands reside in to your PATH variable, and you can call them from anywhere.
  
  when you have a CLI open in the directory of the source code of the container you'd like to send to AWS, you have these commands avaliable:
 
 Commands:

  !! Important this command MUST be run before any of the other commands become accessible
      This command only needs to be run ONCE unless you want to access a different amazon account number or account region.
      
  Create-Commands [amazon account number] [amazon account region]
  
  Description:
  
   Creates all the following commands. this command MUST be ran first.
   
   The Create-Commands.bat file should be in its OWN folder, and that folder should be added to the PATH through Environemnt Variables

  Build [name of image]
  
  Runs:
  
   docker build -t [name of image] .
   
  Description: 
  
   First step of PUSH-ing (deploying) your container to AWS


  Create-Repo [name of image]
  
  Runs:
  
   aws ecr create-repository --repository-name [name of image] --image-scanning-configuration scanOnPush=true
   
  Description:
  
   creates a repository on amazon ecr with the name provided. the name provided should be identical to the image name in the Build.bat command
   

  Deploy [name of image]
  
  Runs:
  
   docker tag [name of image] [amazon account number].dkr.ecr.[amazon account region].amazonaws.com/[name of image]
   
   aws ecr get-login-password | docker login --username AWS --password-stdin [amazon account number].dkr.ecr.[amazon account region].amazonaws.com
   
   docker push [amazon account number].dkr.ecr.[amazon account region].amazonaws.com/[name of image]:latest
   
  Description:
  
   tags a docker container with the [name of image] in the format that amazon repo deployment requires, then logs docker into your aws account
   
   then pushes the tagged container into your repository. [name of image] should be identical to [name of image] from the Build.bat command
   
   and the Create-Repo.bat command. both commands MUST be ran first for the inital deployment, but after the first deployment, only Build.bat needs to
   be run before this command.
   
   [amazon account number] and [amazon account region] are already populated when Create-Commands is run.
   
  
  Test [name of image]
  
  Runs docker run -dp 9000:8080 [name of image]
  
  Description:
  
   runs the container in a detached mode. To test your llambda you can curl, or use Postman and direct a request to
   http://localhost:9000/2015-03-31/functions/function/invocations to do some rudimentary tests.
   

 This utility also has compound commands to further optimize deployment
 
   
  Build-Deploy [name of image]
  
  Runs the Build.bat command then the Deploy.bat command

  Build-Test [name of image]
  
  Runsthe Build.bat command then the Deploy.bat command  
