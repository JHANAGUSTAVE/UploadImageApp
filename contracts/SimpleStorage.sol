// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract SimpleStorage {

    string ipfsHash;
     string name;

    mapping(address=>Image[]) private images;
    struct Image{
        string name;
        string imageHash;
       }

       // Defining a constructor    
        constructor() public{   
        name = 'my name'; 
        owner=msg.sender; 
    } 

   function uploadImage(string memory hash, string memory ipfs) public{
       images[msg.sender].push(Image(hash,ipfs)); //
   }

    function set(string memory x) public {
        ipfsHash = x;
    }

    function get() public view returns (string memory) {
        return ipfsHash;
    }

    function changeName(string memory _name) public onlyOwner {
    name = _name;
  }

    // Private state variable 
    address payable owner;  
  
    // Function to get  
    // address of owner 
    function getOwner( 
    ) public view returns (address) {     
        return owner; 
    } 
  
    // Function to return  
    // current balance of owner 
    function getBalance( 
    ) public view returns(uint256){ 
        return owner.balance; 
    } 

    modifier onlyOwner {
        require(
            msg.sender == owner,
            "Only owner can call this function."
        );
        _;
    }



    


//Using SafeMath
  using SafeMath for uint;
    function exec(uint a, uint b) public pure returns (uint){
        return a.add(b);
    }
 
 
  //security features to protect 

  mapping (address => uint256) public balanceOf;

  function transfer(address _to, uint256 _value) public {
    /* Check if sender has balance and for overflows */
    require(balanceOf[msg.sender] >= _value && balanceOf[_to] + _value >= balanceOf[_to]);

    /* Add and subtract new balances */
    balanceOf[msg.sender] -= _value;
    balanceOf[_to] += _value;
}

     // Reentrancy 
    mapping (address => uint) private userBalances;

    function withdrawBalance() public {
    uint amountToWithdraw = userBalances[msg.sender];
    userBalances[msg.sender] = 0;
    (bool success, ) = msg.sender.call.value(amountToWithdraw)(""); // The user's balance is already 0, so future invocations won't withdraw anything
    require(success);
    }


    // Used by Circuit Breaker pattern to switch contract on / off
    bool private stopped = false;

    /**
    * @dev Indicates that the owner has performed an emergency stop
    * @param _owner The owner of the image
    * @param _stop Indicates whether to stop or resume
    */
    event LogEmergencyStop(
        address indexed _owner, 
        bool _stop
    );

    /**
    * @dev Prevents execution in the case of an emergency
    */
    modifier stopInEmergency { 
        require(!stopped); 
        _;
    }


     /**
    * @notice Pause the contract. 
    * It stops execution if certain conditions are met and can be useful 
    * when new errors are discovered. 
    * @param _stop Switch the circuit breaker on or off
    */

    function emergencyStop(bool _stop) onlyOwner public {
        stopped = _stop;
        emit LogEmergencyStop(owner, _stop);
    }
}
