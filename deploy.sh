docker build -t williampring/multi-client:latest -t williampring/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t williampring/multi-server:latest -t williampring/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t williampring/multi-worker:latest -t williampring/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push williampring/multi-client:latest
docker push williampring/multi-server:latest
docker push williampring/multi-worker:latest
docker push williampring/multi-client:$SHA
docker push williampring/multi-server:$SHA
docker push williampring/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployment/server-deployment server=williampring/multi-server:$SHA
kubectl set image deployment/client-deployment server=williampring/multi-client:$SHA
kubectl set image deployment/worker-deployment server=williampring/multi-worker:$SHA