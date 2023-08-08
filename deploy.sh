docker build -t herogarp/multi-client:latest -t herogarp/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t herogarp/multi-server -t herogarp/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t herogarp/multi-worker-f -t herogarp/multi-worker:$SHA  ./worker/Dockerfile ./worker
docker push herogarp/multi-client:latest
docker push herogarp/multi-server:latest
docker push herogarp/multi-worker:latest
docker push herogarp/multi-client:$SHA
docker push herogarp/multi-server:$SHA
docker push herogarp/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=herogarp/multi-server:$SHA
kubectl set image deployments/client-deployment client=herogarp/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=herogarp/multi-worker:$SHA