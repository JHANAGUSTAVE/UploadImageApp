# Deployed Addresses

## Rinkeby TestNet

```bash
$ truffle migrate --reset --compile-all --network rinkeby

Compiling ./contracts/ImageRegister.sol...
Compiling ./contracts/Migrations.sol...
Compiling @openzeppelin/contracts/math/SafeMath.sol...
Compiling @openzeppelin/contracts/token/ERC20/ERC20.sol...
Writing artifacts to ./build/contracts

Using network 'rinkeby'.

Starting migrations...
======================
> Network name:    'develop'
> Network id:      5777
> Block gas limit: 6721975 (0x6691b7)


1_initial_migration.js
======================

   Replacing 'Migrations'
   ----------------------
   > transaction hash:    0x50eaa65f44e743cf58f0e5a0cc15bda9000e92ca1acb523b938e3892388e6346
   > Blocks: 0            Seconds: 0
   > contract address:    0x4d41bf483e39b2c8a5CEcd18086a1384919DF738
   > block number:        1
   > block timestamp:     1609472987
   > account:             0x64889B35444c1a942fF91656FeB7fFc491362C88
   > balance:             99.99549142
   > gas used:            225429 (0x37095)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00450858 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.00450858 ETH


2_deploy_contracts.js
=====================

   Replacing 'SimpleStorage'
   -------------------------
   > transaction hash:    0x7a10143ba9793dcb3cf2bd18e8f6f2089b2f7983eb71f6d9ea879c4499154447
   > Blocks: 0            Seconds: 0
   > contract address:    0x5d50bBc750389700e37A23cB50Dc4748E1308936
   > block number:        3
   > block timestamp:     1609472993
   > account:             0x64889B35444c1a942fF91656FeB7fFc491362C88
   > balance:             99.97705584
   > gas used:            879416 (0xd6b38)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01758832 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.01758832 ETH


Summary
=======
> Total deployments:   2
> Final cost:          0.0220969 ETH
