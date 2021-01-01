const path = require("path");

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  contracts_build_directory: path.join(__dirname, "client/src/contracts"),
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    }
  },
  compilers: {
    solc: {
        version: "0.6.0" // or find out what the latest version is and use that instead
    }
      },
      ropsten: {
        provider: () =>
          new HDWalletProvider(
            process.env.MNENOMIC,
            'https://ropsten.infura.io/' + process.env.INFURA_API_KEY
          ),
        network_id: 3,
    },
    kovan: {
      provider: () =>
        new HDWalletProvider(
          process.env.MNENOMIC,
          'https://kovan.infura.io/' + process.env.INFURA_API_KEY
        ),
      network_id: 42,
    },
    rinkeby: {
      provider: () =>
        new HDWalletProvider(
          process.env.MNENOMIC,
          'https://rinkeby.infura.io/' + process.env.INFURA_API_KEY
        ),
      network_id: 4,
    },
    // main ethereum network(mainnet)
    main: {
      provider: () =>
        new HDWalletProvider(
          process.env.MNENOMIC,
          'https://mainnet.infura.io/' + process.env.INFURA_API_KEY
        ),
      network_id: 1,
    },

}

