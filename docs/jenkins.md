# Jenkins

## How to contribute

If you want to contribute to the project, you can add new jobs in the `jenkins/jobs` folder.


## Login

You can access to your Jenkins instance at `http://87.106.120.25:8080`.

Login with the credentials:

    username: admin
    password: admin


## Things to do before using the Jenkins instance

- You have to create new credentials to clone your GitHub repository (private or public).

    Go to `Credentials` > `System` > `Global credentials (unrestricted)` > `Add Credentials`.

    Select `SSH Username with private key` and fill the form with your GitHub credentials.

    Then, you have to remember the ID of the credentials you just created.

- You have to disable the Host Key Verification.

    Go to `Manage Jenkins` > `Security` > `Git Host Key Verification Configuration` and select `No verification`.

## Jobs

There are 3 jobs in the Jenkins instance:

- Google Cloud Registry: This job is used to connect to the Google Cloud Registry.

    It takes two parameters:
    - `GCLOUD_PROJECT_ID`: The Google Cloud project ID.
    - `GCLOUD_SERVICE_ACCOUNT_KEY`: The Google Cloud service account key in JSON format.

- link-project: This job is used to create an other job in the Projects folder. The job created will build and deploy your application.

    It takes seven parameters:
    - `GITHUB_URL`: The GitHub URL of your application.
    - `GITHUB_SSH`: The ID of the credentials you created to clone your GitHub repository.
    - `DISPLAY_NAME`: The name of the new job.
    - `GCLOUD_PROJECT_ID`: The Google Cloud project ID.
    - `GCLOUD_PROJECT_LOCATION`: The Google Cloud project location.
    - `GKE_CLUSTER_NAME`: The Google Kubernetes Engine cluster name.
    - `GOOGLE_ARTIFACT_REGISTRY`: The Google Artifact Registry depot name.

    After the new job is created, you can access in the Projects folder and run it.

- Build all base images: This job is used to build all the base docker images.


## How to use the whanos project

To use the whanos project, your application must follow the following structure:

Example of a javascript application:
    
    .
    ├── Dockerfile
    ├── .dockerignore
    ├── whanos.yml
    ├── package.json
    ├── package-lock.json
    └── app
        └── app.js


You have to do the following steps:

- Launch the job `Build all base images` which is in the `Whanos Base images` folder.
- Launch the job `Google Cloud Registry` by filling the parameters.
- Launch the job `link-project` by filling the parameters.

Then, you have to go to the `Projects` folder and run the job you just created.