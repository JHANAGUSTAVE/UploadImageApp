# UploadImageApp 


A simple application that lets users upload an image (stored using IPFS and Ethereum blockchain) and displays the image.
Dependencies

    Truffle
    Solidity
    React.js
    web3
    Infuria
    IPFS API: ipfs-http-api

Storage

Images are uploaded to IPFS with the reference stored in a smart contract deployed on the Ethereum blockchain. This reference allows access to the file on IPFS.
Client App

Built using React.js.

1- Prerequisites

    You will need Metamask plugin for Chrome.
    Make sure you have Node.js installed.

2- Installation

    Install Truffle Framework and Ganache CLI globally. If you prefer, the graphical version of Ganache works as well.

    npm install -g truffle
    npm install -g ganache-cli

    Run the development blockchain.

    ganache-cli

  3- Open another terminal, clone this repo and install its dependencies.

    git clone https://github.com/JHANAGUSTAVE/UploadImageApp.git

     cd UploadImageApp

     npm install
     
     
  

4- Compile and migrate the smart contracts.

truffle compile
truffle migrate

# You can combine into one command
truffle migrate --reset ---compile-all




5- Start the application

npm run start

6- Navigate to http://localhost:3000/ in your browser.




