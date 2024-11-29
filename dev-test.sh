docker image pull ghcr.io/objetos-aprendizaje/portal-administracion:latest --platform=linux/amd64
docker image pull ghcr.io/objetos-aprendizaje/portal-web:latest --platform=linux/amd64

kubectl create namespace poa-live-240823
kubectl apply -n poa-live-240823 -f ./extra-manifest-examples/
helm install poalive240823 ./portal-objetos-aprendizaje --namespace poa-live-240823

---

docker image pull ghcr.io/objetos-aprendizaje/portal-administracion:latest --platform=linux/amd64
docker image pull ghcr.io/objetos-aprendizaje/portal-web:latest --platform=linux/amd64

helm repo add poa-repo https://objetos-aprendizaje.github.io/helm-repo/
kubectl create namespace poa-live-240823
kubectl apply -n poa-live-240823 -f ./extra-manifest-examples/
helm install poalive240823 poa-repo/portal-objetos-aprendizaje --namespace poa-live-240823
