# CCinstructions
Step to build
Build Google Cloud Storage bucket using Terraform
Upload model file to bucket
Update config for application for bucketname and bucketfolder if changed
Dockerize image
Build Google Cloud Run using Terraform
Note: make service account from GCP and create JSON key and put the key in the same directory with main app
Docker
how to build docker images :

cd Bangkit-C22CB-Company-Based-Capstone/CC
docker build -t chatbot:0.1 .
it will build ubuntu server and all the app configurations in Dockerfile

check if the docker image built successfully.

docker images
run the docker image to the container by writing this command

docker run -p 8080:8080 chatbot:0.1
or for naming it :

docker run -p 8080:8000 --name chatbot-traveloka chatbot:0.1
check if it run successfully on port 8080

curl http://localhost:8080 | curl http://0.0.0.0:8080
to get inside the server / container use this command :

docker exec -it [container_id] bash | docker exec -it [container_id] sh
ls
exit
Evicted Pods Problem
if there is a fail container/pod with status evicted, write this command to delete all of them :

kubectl get pod | grep Evicted | awk '{print $1}' | xargs kubectl delete pod
Artifact Registry
how to pull from artifact registry :

gcloud auth configure-docker us-central1-docker.pkg.dev
now you got the permission and ready to pull it to local docker image

docker pull us-central1-docker.pkg.dev/sacred-armor-346113/chatbot-tvlk/chatbot-app:0.1
Terraform
Initialize a working directory containing Terraform configuration files. :

terraform init
evaluates a Terraform configuration to determine the desired state of all the resources it declares, then compares that desired state to the real infrastructure objects being managed with the current working directory and workspace :

terraform plan
terminates resources managed by your Terraform project :

terraform destroy
