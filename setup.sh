
#Set Project ID
gcloud config set project $PROJECT_ID
#Enable services
gcloud services enable compute.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable iap.googleapis.com
gcloud services enable oslogin.googleapis.com