folder('/Whanos base images') {
    description('Folder for Whanos base images.')
    displayName('Whanos base images')
}
folder('/Projects') {
    description('Folder for projects.')
    displayName('Projects')
}

def languages = ['befunge', 'c', 'java', 'javascript', 'python', 'cpp', 'go']

languages.each { language ->
    freeStyleJob("/Whanos base images/whanos-$language") {
        steps {
            shell("docker build -t whanos-$language /usr/share/jenkins/ref/images/$language -f /usr/share/jenkins/ref/images/$language/Dockerfile.base")
        }
    }
}

freeStyleJob('/Whanos base images/Build all base images') {
    publishers {
        downstream(
            languages.collect {
                language -> "Whanos base images/whanos-$language"
            }
        )
    }
}

freeStyleJob('/Google Cloud Registry') {
    parameters {
        stringParam("GCLOUD_PROJECT_ID", null, "Google Cloud ID project")
        fileParam("GCLOUD_SERVICE_ACCOUNT_KEY", "Google Cloud Service Account file")
    }
    steps {
        shell("gcloud auth activate-service-account --key-file=GCLOUD_SERVICE_ACCOUNT_KEY")
        shell("gcloud config set project \$GCLOUD_PROJECT_ID")
    }
}

freeStyleJob('/link-project') {
    parameters {
        stringParam("GITHUB_URL", null, "GitHub repository name")
        stringParam("GITHUB_SSH", null, "GitHub SSH credentials")
        stringParam("DISPLAY_NAME", null, "Display name for the job")
        stringParam("GCLOUD_PROJECT_ID", null, "Google Cloud ID project")
        stringParam("GCLOUD_PROJECT_LOCATION", null, "Google Cloud location project")
        stringParam("GKE_CLUSTER_NAME", null, "Google Cloud cluster name")
        stringParam("GOOGLE_ARTIFACT_REGISTRY", null, "Google Cloud depot name")
    }
    steps {
        dsl {
            text('''freeStyleJob("/Projects/\$DISPLAY_NAME") {
                scm {
                    git {
                        remote {
                            url("\$GITHUB_URL")
                            credentials("\$GITHUB_SSH")
                        }
                        branches('main')
                    }
                }
                triggers {
                    scm('* * * * *')
                }
                steps {
                    shell(\"/var/jenkins_home/detect_language.sh \$GCLOUD_PROJECT_ID \$GOOGLE_ARTIFACT_REGISTRY \$GKE_CLUSTER_NAME \$GCLOUD_PROJECT_LOCATION\")
                }
            }'''.stripIndent())
        }
    }
}