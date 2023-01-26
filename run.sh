echo "1. build image"
docker build -t geth-client .
echo "2. init volume directory"
# copy file from init container
docker run -d --name init geth-client
docker cp init:/root/.ethereum ./geth-rpc-endpoint-volume
docker cp init:/root/.ethereum  ./geth-bootnode-volume
docker cp init:/root/.ethereum ./geth-miner-volume
echo "3. remove nodekey hex"
# remove nodekey hex
rm -rf ./geth-rpc-endpoint-volume/geth/nodekey
rm -rf ./geth-bootnode-volume/geth/nodekey
rm -rf ./geth-miner-volume/geth/nodekey
echo "4. run container"
# run container
docker-compose up -d
echo "5. done"
docker rm -f init
