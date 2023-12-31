## Helm / auto-deploy configuration

## How to contribute

If you want to contribute to the project, you can add new charts in the `helm/charts` folder.
Or just you can add new values in the `helm/values` folder.

## Helm configuration

The helm default configuration is in the `helm/values` folder.

It is jsut a basic deployment configuration. You can add new values in the `helm/values` folder.

This is the basic architecture of the auto-deploy folder:

    .
    ├── kubernetes
    │   ├── auto-deploy
    │   │   ├── templates
    │   │   │   ├── deployment.yaml
    │   │   │   ├── service.yaml
    │   │   │   └── ingress.yaml
    │   │   └── values.yaml
    │   │   └── Chart.yaml


## How to use

If you have a whanos.yaml file inside your repository, the jenkins will deploy the application automatically.
I will base on the whanos.yaml file to deploy the application.
And for the image it will use the Dockerfile in the repository or ours images.