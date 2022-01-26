# Unique marketplace start up instruction

frontend:
https://github.com/UniqueNetwork/unique-marketplace/tree/release/v2.3.1

backend:
https://github.com/UniqueNetwork/unique-marketplace-api/tree/v0.5

escrow:
https://github.com/UniqueNetwork/unique-marketplace-escrow/tree/v0.7

kusama escrow:
https://github.com/UniqueNetwork/unique-marketplace-escrow-kusama/tree/v0.8

## Prerequisites
 - OS: Ubuntu 18.04 or 20.04
 - docker CE 20.10 or up
 - docker-compose 1.25 or up
 - git
 - Google Chrome Browser

## How to install

1. Perform the steps 1-4 from [this instruction](https://github.com/UniqueNetwork/marketplace-docker/blob/master/README.md). As a result you will get admin seed, admin address, matcher contract address. You probably may want to see steps 6-7 to understand better how to fill the `.env` file. Later you will need your admin seed, admin address and matcher contract address.  
2. Copy `.branches.example.env` to `.branches.env` and `.example.env` to `.env`.
3. Correct the `.branches.env` file. Actually there only one thing makes sense to be changed: frontend envs starting with `FRONT_`.  
4. Correct the `.env` file. You will need some data from the step 1. 
   - ADMIN_SEED - your admin account seed
   - ESCROW_ADDRESS - your admin address
   - MATCHER_CONTRACT_ADDRESS and CONTRACT_ADDRESS - need to be filled with the same value - matcher contract address.
   - UNIQUE_API - your domain which will point to the api (usually subdomain like api.market.example.com)
   - UNIQUE_COLLECTION_IDS - can be filled later.
5. Run the `scripts/download_repos.sh`. It should download all the repos from the `.branches.env`.
6. Run `docker-compose up -d`.
7. Set up nginx (or another webserver) to proxy frontend to the 3000 port and backend (which is UNIQUE_API from `.env`) to the 5000 port.
