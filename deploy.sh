docker build -t dita/multi-client-k8s:latest -t dita/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t dita/multi-server-k8s-pgfix:latest -t dita/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t dita/multi-worker-k8s:latest -t dita/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push dita/multi-client-k8s:latest
docker push dita/multi-server-k8s-pgfix:latest
docker push dita/multi-worker-k8s:latest

docker push dita/multi-client-k8s:$SHA
docker push dita/multi-server-k8s-pgfix:$SHA
docker push dita/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dita/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=dita/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=dita/multi-worker-k8s:$SHA