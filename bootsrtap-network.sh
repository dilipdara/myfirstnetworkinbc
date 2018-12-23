# bin/bash
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>"

echo "generating certificates"
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
cryptogen generate --config=./crypto-config.yaml
export FABRIC_CFG_PATH=$PWD

echo "====================================================================="

echo "Genrating Genesis Block"

configtxgen -profile TwoOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block
export CHANNEL_NAME=mysecondchannel

echo "Create a Channel Configuration Transaction"
echo "=========================================="
configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME

echo "Defining the Anchor Peers"
echo "========================="

configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg benzMSP
configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID $CHANNEL_NAME -asOrg audiMSP

echo "Bootstraping the network"
echo "========================"

docker-compose -f docker-compose-cli.yaml up