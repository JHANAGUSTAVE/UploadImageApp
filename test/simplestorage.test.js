const SimpleStorage = artifacts.require("./SimpleStorage.sol");

// test suite

contract('simpleStorage', (accounts) => {
  // Contract instance
  let simpleStorageInstance

 // It should have an owner
 it('has an owner', async () => {
  assert.equal(await simpleStorageInstance.owner(), owner, 'has an owner')
})

  // Only the contracgt owner can perform an emergency stop
  it('should allow the owner to perform an emergency stop', async () => {
    await simpleStorageInstance.emergencyStop(true, { from: owner })
  })

  // It should log an LogEmergency event when pausing / restarting a contract
  it('should emit a LogEmergencyStop event when performing an emergency stop', async () => {
    const tx = await simpleStorageInstance.emergencyStop(true, { from: owner })

    truffleAssert.eventEmitted(tx, 'LogEmergencyStop', (ev) => {
      return ev._owner === owner && ev._stop === true
    })
  })


  

  // It should store an image on the blockchain
  it('should store an image', async () => {
    const success = await simpleStorageInstance.uploadImage.call(
      ipfsHash1,
      title1,
      description1,
      tags1
    )
    assert.equal(success, true, 'it returns true')
  })

  it('should emit a LogImageUploaded event when storing an image', async () => {
    const tx = await simpleStorageInstance.uploadImage(
      ipfsHash1,
      title1,
      description1,
      tags1
    )

    truffleAssert.eventEmitted(tx, 'LogImageUploaded', (ev) => {
      return (
        ev._owner === owner &&
        ev._ipfsHash === ipfsHash1 &&
        ev._title === title1 &&
        ev._description === description1 &&
        ev._tags === tags1 &&
        ev._uploadedOn.toNumber() !== 0
      )
    })
  })

   
});