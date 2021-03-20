docker build -t psa39/multi-client-k8s:latest -t psa39/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t psa39/multi-server-k8s:latest -t psa39/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t psa39/multi-worker-k8s:latest -t psa39/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker
docker push psa39/multi-client-k8s:latest
docker push psa39/multi-server-k8s:latest
docker push psa39/multi-worker-k8s:latest

docker push psa39/multi-client-k8s:$SHA
docker push psa39/multi-server-k8s:$SHA
docker push psa39/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=psa39/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=psa39/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=psa39/multi-worker-k8s:$SHA