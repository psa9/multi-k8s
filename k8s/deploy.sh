docker build -t psa39/multi-client:latest -t psa39/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t psa39/multi-server:latest -t psa39/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t psa39/multi-worker:latest -t psa39/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push psa39/multi-client:latest
docker push psa39/multi-server:latest
docker push psa39/multi-worker:latest

docker push psa39/multi-client:$SHA
docker push psa39/multi-server:$SHA
docker push psa39/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=psa39/multi-server:$SHA
kubectl set image deployments/client-deployment client=psa39/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=psa39/multi-worker:$SHA
