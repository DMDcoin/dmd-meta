#!/bin/sh


echo "compiling hbbft-posdao-contracts"
cd hbbft-posdao-contracts
npm ci
truffle compile
cd ..



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
#docker run -it --rm --mount type=bind,source="$(pwd)",target=/root mcr.microsoft.com/dotnet/sdk:2.1 dotnet tool install --global Nethereum.Generator.Console --version 3.6.1 && /root/.dotnet/tools/Nethereum.Generator.Console generate from-truffle --directory ~/hbbft-posdao-contracts/build/contracts --outputPath /root/dmd-vision/Contracts --namespace DMDVision.Contracts

docker run -it --rm --mount type=bind,source="$(pwd)"/hbbft-posdao-contracts,target=/root/hbbft-posdao-contracts --mount type=bind,source="$(pwd)"/dmd-vision,target=/root/dmd-vision mcr.microsoft.com/dotnet/sdk:2.1 bin/bash -c "dotnet tool install --global Nethereum.Generator.Console --version 3.6.1 && /root/.dotnet/tools/Nethereum.Generator.Console generate from-truffle --directory ~/hbbft-posdao-contracts/build/contracts --outputPath /root/dmd-vision/Contracts --namespace DMDVision.Contracts"


 # docker run -it --rm  --mount  type=bind,source="$(pwd)"/hbbft-posdao-contracts,target=/root/hbbft-posdao-contracts --mount type=bind,source="$(pwd)"/dmd-vision,target=/root/dmd-vision mcr.microsoft.com/dotnet/sdk:2.1 dotnet tool install --global Nethereum.Generator.Console --version 3.6.1 && /bin/bash