language=null
project_id=$1
depot_name=$2
cluster_name=$3
location=$4

if [ -f "Makefile" ]; then
  language="c"
fi

if [ -f "app/pom.xml" ]; then
  language="java"
fi

if [ -f "package.json" ]; then
  language="javascript"
fi

if [ -f "requirements.txt" ]; then
  language="python"
fi

if [ -f "CMakeLists.txt" ]; then
  language="cpp"
fi

if [ -f "app/go.mod" ]; then
  language="go"
fi

if [ -f "app/main.bf" ]; then
  language="befunge"
fi

echo "Application language is $language"

if [ -f "Dockerfile" ]; then
  docker build . -t whanos-$language
else
  docker build . -t whanos-$language -f /var/jenkins_home/images/$language/Dockerfile.standalone
  ls -l /var/jenkins_home/images/$language
fi

gcloud auth configure-docker $location-docker.pkg.dev

docker tag whanos-$language $location-docker.pkg.dev/$project_id/$depot_name/whanos-$language
docker push $location-docker.pkg.dev/$project_id/$depot_name/whanos-$language

if [ -f "whanos.yml" -o -f "whanos.yaml" ]; then
  gcloud container clusters get-credentials $cluster_name --region $location --project $project_id

  yq e -i ".image.repository = \"$location-docker.pkg.dev/$project_id/$depot_name/whanos-$language\"" /var/jenkins_home/kubernetes/auto-deploy/values.yaml

  replicas=$(yq e '.deployment.replicas' whanos.yml)
  ports=$(yq e '.deployment.ports[0]' whanos.yml)
  yq eval ".deployment.replicas = $replicas | .deployment.ports[0] = $ports" -i /var/jenkins_home/kubernetes/auto-deploy/values.yaml

  cat /var/jenkins_home/kubernetes/auto-deploy/values.yaml

  helm status whanos-$language
  if [ $? -eq 0 ]; then
    helm upgrade whanos-$language /var/jenkins_home/kubernetes/auto-deploy --values /var/jenkins_home/kubernetes/auto-deploy/values.yaml
  else
    helm install whanos-$language /var/jenkins_home/kubernetes/auto-deploy --values /var/jenkins_home/kubernetes/auto-deploy/values.yaml
  fi
fi