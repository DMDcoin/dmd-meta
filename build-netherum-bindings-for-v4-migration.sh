#!/bin/bash


# echo "compiling claiming contracts"
# cd dmdv4migration/contracts
# npm ci
# truffle compile
# cd ../..



#cp hbbft-posdao-contracts/build/contracts/*.json dmd-vision/ABI
# it became tremendously difficult to develop int dotnetcore 5,
# but the API generater Tool requires dotnetcore 2.1
# since docker runs in a  complex permission setup,
# the created files are owned by root.
# the script might be able to improve by splitting up the Actions:
# docker run
# docker cp
# docker stop
# docker rm

echo "copying truffle build artifacts to dmd-vision"
#docker run -it --rm --mount type=bind,source="$(pwd)",target=/root mcr.microsoft.com/dotnet/sdk:2.1 dotnet tool install --global Nethereum.Generator.Console --version 3.6.1 && /root/.dotnet/tools/Nethereum.Generator.Console generate from-abi --directory ~/hbbft-posdao-contracts/build/contracts --outputPath /root/dmd-vision/Contracts --namespace DMDVision.Contracts

export IMAGEID=$(docker build --quiet ./docker-nethereumgenerator)
export CONTAINERNAME=nethereumbindings_$RANDOM$RANDOM$RANDOM

# start the container, it just sleeps and awaits incoming files an exec commmands.
docker run -d --name=$CONTAINERNAME $IMAGEID sleep 300
docker exec $CONTAINERNAME mkdir /root/truffle-artifacts
docker cp ./dmdv4migration/contracts/build/contracts/ $CONTAINERNAME:/root/truffle-artifacts
#docker exec $CONTAINERNAME cat /root/README.md
docker exec $CONTAINERNAME mkdir /root/out-nethereum

docker exec $CONTAINERNAME /root/.dotnet/tools/Nethereum.Generator.Console generate from-truffle --directory /root/truffle-artifacts/contracts --outputPath /root/out-nethereum --namespace DMDVision.ContractsClaiming

echo "copying c# contract files to ./dmd-vision/ContractsClaiming"
# copy back the generated files
docker cp $CONTAINERNAME:/root/out-nethereum ./dmd-vision/ContractsClaiming
echo "done, cleaning up."
echo "stopping docker container $CONTAINERNAME"
docker stop $CONTAINERNAME
echo "removing docker container $CONTAINERNAME"
docker rm $CONTAINERNAME

