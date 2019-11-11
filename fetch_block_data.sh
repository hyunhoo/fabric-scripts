#!/bin/sh
#
# This script is for fetch specific block in fabric-cli container.
#
# You can use $ ./fetch_block_data.sh {block_num}
# {block_num} options: number, newest, oldest

function getEnv() {
    PEER=$1
	if [[ "$PEER" == "peer1" ]]; then
		export MSPID=""
		export MSPPATH=""
		export PEER_ADDRESS=""
	elif [[ "$PEER" == "peer2" ]]; then
		export MSPID=""
		export MSPPATH=""
		export PEER_ADDRESS=""
	else
		echo "Wrong arg"
	fi
}

function fetchBlock() {
    ORDERER_URL=""
    CHANNEL_NAME=""

    # Peer1
    getEnv "peer1"
    peer channel fetch "$BLOCK_NUM" \
        -o "$ORDERER_URL" \
        -c "$CHANNEL_NAME" \
        ./peer1_block.block

    # Peer2
    getEnv "peer2"
    peer channel fetch "$BLOCK_NUM" \
        -o "$ORDERER_URL" \
        -c "$CHANNEL_NAME" \
        ./peer2_block.block
}

function decodeBlock() {
    # Decoding to readable file
    ~/utils/bin/configtxlator proto_decode --input ./peer1_block.block --type common.Block > ./peer1_block.json
    ~/utils/bin/configtxlator proto_decode --input ./peer2_block.block --type common.Block > ./peer2_block.json
}

BLOCK_NUM=$1

fetchBlock
decodeBlock
