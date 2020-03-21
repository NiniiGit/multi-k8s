docker build -t NiniiGit/multi-client:latest -t NiniiGit/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t NiniiGit/multi-server:latest -t NiniiGit/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t NiniiGit/multi-worker:latest -t -t NiniiGit/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push NiniiGit/multi-client:latest
docker push NiniiGit/multi-server:latest
docker push NiniiGit/multi-worker:latest

docker push NiniiGit/multi-client:$SHA
docker push NiniiGit/multi-server:$SHA
docker push NiniiGit/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=NiniiGit/multi-server:$SHA
kubectl set image deployments/client-deployment client=NiniiGit/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=NiniiGit/multi-worker:$SHA