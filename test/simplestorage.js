const SimpleStorage = artifacts.require("./SimpleStorage.sol");

// const SimpleStorage = artifacts.require("./SimpleStorage.sol");

contract("SimpleStorage", accounts => {

  let instance;
  beforeEach('should setup the contract instance', async () => {
    instance = await SimpleStorage.deployed();
  });
 
  it("should return the name", async ()=> {
    const value = await instance.getName();
 
    assert.equal(value, 'my name');
  });
 
  it("should return change the name", async ()=> {
    await instance.changeName('your name');
    const value = await instance.getName();
 
    assert.equal(value, 'your name');
  });
 
  it('should execute only by the owner', async()=>{
    await instance.changeName('modifier');
    const value = await instance.getName();
 
    assert.equal(value, 'modifier');
  })
  // it("...should store the value 89.", async () => {
  //   const simpleStorageInstance = await SimpleStorage.deployed();

  //   // Set value of 89
  //   await simpleStorageInstance.set(89, { from: accounts[0] });

  //   // Get stored value
  //   const storedData = await simpleStorageInstance.get.call();

  //   assert.equal(storedData, 89, "The value 89 was not stored.");
  // });
  
});
