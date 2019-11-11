#!/bin/sh
#
# This script is for fetch specific block.
#
# You can use $ ./fetch_block_data_docker.sh {block_num}
# {block_num} options: number, newest, oldest

BLOCK_NUM=$1

ORDERER_URL=""
CHANNEL_NAME=""

# Peer1
docker exec \
	-e CORE_PEER_LOCALMSPID="" \
	-e CORE_PEER_MSPCONFIGPATH="" \
	-e CORE_PEER_ADDRESS="" \
	-ti cli \
	peer channel fetch "$BLOCK_NUM" \
	-o "$ORDERER_URL" \
	-c "$CHANNEL_NAME" \
	./test/peer1_block.block

# Peer2
docker exec \
	-e CORE_PEER_LOCALMSPID="" \
	-e CORE_PEER_MSPCONFIGPATH="" \
	-e CORE_PEER_ADDRESS="" \
	-ti cli \
	peer channel fetch "$BLOCK_NUM" \
	-o "$ORDERER_URL" \
	-c "$CHANNEL_NAME" \
	./test/peer2_block.block


# Decoding to readable file
~/utils/bin/configtxlator proto_decode --input ./peer1_last.block --type common.Block > ./peer1_block.json
~/utils/bin/configtxlator proto_decode --input ./peer2_last.block --type common.Block > ./peer2_block.json
