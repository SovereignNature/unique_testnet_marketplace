# Unique marketplace start up instruction

## Prerequisites
 - OS: Ubuntu 18.04 or 20.04
 - docker CE 20.10 or up
 - docker-compose 1.25 or up
 - git
 - Google Chrome Browser

## How to install

### Preparing

DISCLAIMER: If you already have an account - Substrate address and you know what the Polkadot.js.org Chrome extension is and especially if you already have minted some collections and tokens to this address previously, please skip steps 1-2 from [this instruction](https://github.com/UniqueNetwork/marketplace-docker/blob/master/README.md) and just follow steps 3-4 ("Get Unique" and "Deploy Marketplace Smart Contract") and please use your existing address as the admin one in the Step 4.

Perform the steps 1-4 from [this instruction](https://github.com/UniqueNetwork/marketplace-docker/blob/master/README.md).
As a result you will get admin seed, admin address, matcher contract address.
Later you will need your admin seed, admin address and matcher contract address.

### Installation

1. Copy `.branches.example.env` to `.branches.env` and `.example.env` to `.env`.
2. [Only if you have your own forked repos] Correct the `.branches.env` file. Actually there only one thing makes sense to be changed: frontend envs starting with `FRONT_`.  
3. Correct the `.env` file. You will need some data from the preparing phase. 
   - ADMIN_SEED - your admin account seed
   - ESCROW_ADDRESS - your admin address
   - MATCHER_CONTRACT_ADDRESS and CONTRACT_ADDRESS - need to be filled with the same value - matcher contract address.
   - UNIQUE_API - your domain which will point to the api (usually subdomain like api.market.example.com). For local deployment it can be "http://localhost:5000". But in this case please make sure that you have set the `DISABLE_SECURITY` to `true`.
   - UNIQUE_COLLECTION_IDS - can be filled later. Or you can fill it with collections you have created with minting scripts.
4. Run the `scripts/download_repos.sh`. It should download all the repos from the `.branches.env`.
5. Run `docker-compose up -d`.
6. Set up nginx (or another webserver) to proxy frontend to the 3000 port and backend (which is UNIQUE_API from `.env`) to the 5000 port. You can find example in the `external_nginx_example.conf`. 

### Notes

### Troubleshooting

##### Backend can't connect to PostgreSQL
It may say something like `ECONNREFUSED` to 5432. First, please double check old docker networks and running containers. Or it may be an already running PostgreSQL instance. But such error can occur even on a clean fresh machine.
This is a docker-related error and can be simply fixed with docker tools:
```bash
docker-compose down
docker system prune -f
docker-compose up -d
```
The command `docker system prune -f` seems to be frightening, but it just removes stopped containers and networks. And helps to deal with docker chaos.

##### Market is working properly but the pictures have not been shown.
Some browsers can cut off the images if it was served by localhost. For example, Brave does so. Please check whether your browser has such settings (usually near the address bar), make sure that extensions don't cut images requests or try to run it in fresh Chrome.

If there are no problems with image request, please open the Developer Console in browser (Ctrl+Shift+I or Cmd+Shift+I) and try to find any cracked picture in the DOM tree. There may be a picture with link starting with something like "http://localhost:8080". It means that this collection have a URL part pointing to the local IPFS and you should create new collection with pictures uploaded to globally available IPFS gateway.

##### You try to sell the NFT to the market but it stucks with spinner and 'Waiting for deposit' state.
It may be due to stop and start escrows with big delay (hours or days). Escrows try to catch up with the chain, but it takes some time. If you know for sure that there were not any interesting events during the downtime, you can restart escrows from the latest block. Just add such env var to the `.env` file:

```env
UNIQUE_START_FROM_BLOCK=latest
```

And then restart the docker-compose:

```bash
docker-compose stop
docker-compose build new_escrow_unique
docker-compose build new_escrow_kusama
docker-compose up -d
```

After some time (a minute) you can remove this line from the `.env` file and restart escrows once more as it shown in the previous snippet. Escrows will start from the latest block in the database.

### Current actual repo branches
Auxiliary repo links info:

front:
https://github.com/UniqueNetwork/unique-marketplace/tree/release/v2.3.1

api:
https://github.com/UniqueNetwork/unique-marketplace-api/tree/v0.5

escrow:
https://github.com/UniqueNetwork/unique-marketplace-escrow/tree/v0.7

escrow kusama:
https://github.com/UniqueNetwork/unique-marketplace-escrow-kusama/tree/v0.8
