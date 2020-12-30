// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract SimpleStorage {

  address payable owner;
  constructor() public {
      owner = msg.sender; 
     }

     modifier onlyOwner {
        require(
            msg.sender == owner,
            "Only owner can call this function."
        );
        _;
    }

  using SafeMath for uint;
    function exec(uint a, uint b) public pure returns (uint){
        return a.add(b);
    }
 
 
    /** 
    * @title Represents a single image which is owned by someone. 
    */
    struct Image {
        string ipfsHash;        // IPFS hash
        string title;           // Image title
        string description;     // Image description
        string tags;            // Image tags in comma separated format
        uint256 uploadedOn;     // Uploaded timestamp
    }


      // Maps owner to their images
    mapping (address  => Image[]) public ownerToImages;

     //circuit breaker
    bool private stopped = false;


    /**
    * @dev Indicates that a user has uploaded a new image
    * @param _owner The owner of the image
    * @param _ipfsHash The IPFS hash
    * @param _title The image title
    * @param _description The image description
    * @param _tags The image tags
    * @param _uploadedOn The upload timestamp
    */
    event LogImageUploaded(
        address indexed _owner, 
        string _ipfsHash, 
        string _title, 
        string _description, 
        string _tags,
        uint256 _uploadedOn
    );


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
        * @notice associate an image entry with the owner i.e. sender address
        * @dev Controlled by circuit breaker
        * @param _ipfsHash The IPFS hash
        * @param _title The image title
        * @param _description The image description
        * @param _tags The image tag(s)
        */
    function uploadImage(
        string memory _ipfsHash, 
        string memory _title, 
        string memory _description, 
        string memory _tags
    ) public stopInEmergency returns (bool _success) {
            
        require(bytes(_ipfsHash).length == 46);
        require(bytes(_title).length > 0 && bytes(_title).length <= 256);
        require(bytes(_description).length < 1024);
        require(bytes(_tags).length > 0 && bytes(_tags).length <= 256);

        uint256 uploadedOn = now;
        Image memory image = Image(
            _ipfsHash,
            _title,
            _description,
            _tags,
            uploadedOn
        );

        ownerToImages[msg.sender].push(image);

        emit LogImageUploaded(
            msg.sender,
            _ipfsHash,
            _title,
            _description,
            _tags,
            uploadedOn
        );

        _success = true;
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


    




    /** 
    * @notice Returns the number of images associated with the given address
    * @dev Controlled by circuit breaker
    * @param _owner The owner address
    * @return The number of images associated with a given address
    */
    // function getImageCount(address  _owner) 
    //     public view 
    //     stopInEmergency 
    //     returns (uint256) 
    // {
    //     require( _owner != 0x0);
    //     return ownerToImages[_owner].length;
    // }


    /** 
    * @notice Returns the image at index in the ownership array
    * @dev Controlled by circuit breaker
    * @param _owner The owner address
    * @param _index The index of the image to return
    * @return _ipfsHash The IPFS hash
    * @return _title The image title
    * @return _description The image description
    * @return _tags image Then image tags
    * @return _uploadedOn The uploaded timestamp
    */ 
    // function getImage(address _owner, uint8 _index) 
    //     public stopInEmergency view returns (
    //     string memory _ipfsHash, 
    //     string memory _title, 
    //     string memory _description, 
    //     string memory _tags,
    //     uint256 _uploadedOn
    // ) {

    //     require(_owner != 0x0);
    //     require(_index >= 0 && _index <= 2**8 - 1);
    //     require(ownerToImages[_owner].length > 0);

    //     Image storage image = ownerToImages[_owner][_index];
        
    //     return (
    //         image.ipfsHash, 
    //         image.title, 
    //         image.description, 
    //         image.tags, 
    //         image.uploadedOn
    //     );
    // }




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
