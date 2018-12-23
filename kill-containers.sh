# bin/bash
echo "Kill the contains"
echo "======================================================="

docker kill $(docker ps -aq)

echo "Remove the contains"
echo "======================================================="

docker rm $(docker ps -aq)

echo "Remove the Volums"
echo "======================================================="

docker Volume prune | echo "Y"

echo "Remove the Network"
echo "======================================================="

docker network prune | echo "Y"

echo "Remove the crypto-config folder"
echo "======================================================="

rm -rf crypto-config

echo "Remove the content of channnel-artifacts folder"
echo "======================================================="

rm -rf channnel-artifacts/*


