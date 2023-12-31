# Google Cloud


## Setup Google Artifact Registry

### Activate the API

Activate the [Google Artifact Registry API](https://console.cloud.google.com/apis/library/artifactregistry.googleapis.com) for your project.

### Create a service account

If the service account already exists, just add the following roles:

- Artifact Registry Administrator
- Storage Admin

Create a [service account](https://console.cloud.google.com/iam-admin/serviceaccounts) for your project with the following roles:

- Artifact Registry Administrator
- Storage Admin

### Create a key

Create a [key](https://console.cloud.google.com/apis/credentials) for your service account and download the JSON file.

### Create a depot registry

Create a [depot registry](https://console.cloud.google.com/artifacts) for your project with the default settings.








## Setup Google Kubernetes Engine

### Activate the API

Activate the [Google Kubernetes Engine API](https://console.cloud.google.com/apis/library/container.googleapis.com) for your project.

### Create a service account

If the service account already exists, just add the following roles:

- Compute Admin
- Kubernetes Engine Admin
- Service Account User

Create a [service account](https://console.cloud.google.com/iam-admin/serviceaccounts) for your project with the following roles:

- Compute Admin
- Kubernetes Engine Admin
- Service Account User

### Create a key

Create a [key](https://console.cloud.google.com/apis/credentials) for your service account and download the JSON file.

### Create a cluster

Create a [cluster](https://console.cloud.google.com/kubernetes/list) for your project with the following settings:

