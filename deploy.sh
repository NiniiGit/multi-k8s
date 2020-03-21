docker build -t ninadocker73/multi-client:latest -t ninadocker73/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t ninadocker73/multi-server:latest -t ninadocker73/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ninadocker73/multi-worker:latest -t ninadocker73/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ninadocker73/multi-client:latest
docker push ninadocker73/multi-server:latest
docker push ninadocker73/multi-worker:latest

docker push ninadocker73/multi-client:$SHA
docker push ninadocker73/multi-server:$SHA
docker push ninadocker73/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ninadocker73/multi-server:$SHA
kubectl set image deployments/client-deployment client=ninadocker73/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ninadocker73/multi-worker:$SHA