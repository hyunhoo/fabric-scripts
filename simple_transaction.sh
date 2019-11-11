#!/bin/sh
#
# This script is for make transaction(invoke, query).
#
# You can use $ ./simple_transaction.sh {ACTION} {TARGET_PEER} {ARG}

function getEnv() {
	if [[ "$TARGET_PEER" == "peer1" ]]; then
		MSPID=""
		MSPPATH=""
		PEER_ADDRESS=""
	elif [[ "$TARGET_PEER" == "peer2" ]]; then
		MSPID=""
		MSPPATH=""
		PEER_ADDRESS=""
	else
		echo "Wrong arg"
	fi
}

function Invoke() {
	ctor='{"Args":["invoke", "'${ARG}'"]}'

	docker exec \
	-e CORE_PEER_LOCALMSPID=${MSPID} \
	-e CORE_PEER_MSPCONFIGPATH=${MSPPATH} \
	-e CORE_PEER_ADDRESS=${PEER_ADDRESS} \
	-ti cli \
	peer chaincode invoke \
	--channelID ${CHANNEL_NAME} \
	--name ${CC_NAME} \
	--orderer ${ORDERER_URL} \
	--ctor "$ctor"
}

function Query() {
	ctor='{"Args":["query","'${ARG}'"]}'

	docker exec \
	-e CORE_PEER_LOCALMSPID=${MSPID} \
	-e CORE_PEER_MSPCONFIGPATH=${MSPPATH} \
	-e CORE_PEER_ADDRESS=${PEER_ADDRESS} \
	-ti cli \
	peer chaincode query \
	--channelID ${CHANNEL_NAME} \
	--name ${CC_NAME} \
	--orderer ${ORDERER_URL} \
	--ctor "$ctor"
}

ACTION=$1
TARGET_PEER=$2
ARG=$3

ORDERER_URL=""
CHANNEL_NAME=""
CC_NAME=""

getEnv

if [[ "$ACTION" == "invoke" ]]; then
	Invoke
elif [[ "$ACTION" == "query" ]]; then
	Query
fi
