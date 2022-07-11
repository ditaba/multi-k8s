docker build -t 270319883748/multi-client-k8s:latest -t 270319883748/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t 270319883748/multi-server-k8s-pgfix:latest -t 270319883748/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t 270319883748/multi-worker-k8s:latest -t 270319883748/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push 270319883748/multi-client-k8s:latest
docker push 270319883748/multi-server-k8s-pgfix:latest
docker push 270319883748/multi-worker-k8s:latest

docker push 270319883748/multi-client-k8s:$SHA
docker push 270319883748/multi-server-k8s-pgfix:$SHA
docker push 270319883748/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=270319883748/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=270319883748/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=270319883748/multi-worker-k8s:$SHA