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
   - UNIQUE_API - your domain which will point to the api (usually subdomain like api.market.example.com)
   - UNIQUE_COLLECTION_IDS - can be filled later.
4. Run the `scripts/download_repos.sh`. It should download all the repos from the `.branches.env`.
5. Run `docker-compose up -d`.
6. Set up nginx (or another webserver) to proxy frontend to the 3000 port and backend (which is UNIQUE_API from `.env`) to the 5000 port.


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
