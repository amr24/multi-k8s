docker build -t amr24/multi-client:latest -t amr24/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t amr24/multi-server:latest -t amr24/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t amr24/multi-worker:latest -t amr24/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push amr24/multi-client:latest
docker push amr24/multi-server:latest
docker push amr24/multi-worker:latest

docker push amr24/multi-client:$SHA
docker push amr24/multi-server:$SHA
docker push amr24/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=amr24/multi-server:$SHA
kubectl set image deployments/client-deployment server=amr24/multi-client:$SHA
kubectl set image deployments/worker-deployment server=amr24/multi-worker:$SHA