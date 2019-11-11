#!/bin/sh
#
# This script is for generate crypto material(crypto-configs, channel-artifacts).
#
# You can use $ ./generate_crypto_material.sh

CHANNEL_NAME=""

rm -r ./crypto-config ./channel-artifacts

mkdir ./channel-artifacts

# Generate crypto configs
~/utils/bin/cryptogen generate --config=./crypto-config.yaml

# Generate configtx
~/utils/bin/configtxgen -profile SampleGenesis -channelID test_id -outputBlock ./channel-artifacts/genesis.block
~/utils/bin/configtxgen -profile SampleChannel -outputCreateChannelTx ./channel-artifacts/${CHANNEL_NAME}.tx -channelID ${CHANNEL_NAME}

~/utils/bin/configtxgen -profile SampleChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID ${CHANNEL_NAME} -asOrg Org1MSP
~/utils/bin/configtxgen -profile SampleChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID ${CHANNEL_NAME} -asOrg Org2MSP
