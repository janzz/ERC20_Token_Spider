//token_name	
//token_url	https://etherscan.io//address/0x7211f65a7876433635601b9480e57f812a3665d8#code
//spider_time	2018/07/08 12:49:03
//token_Transactions	78 txns
//token_price	

pragma solidity ^0.4.18;

/**
 * @title Ownable
 * @dev Adds onlyOwner modifier. Subcontracts should implement checkOwner to check if caller is owner.
 */
contract Ownable {
    modifier onlyOwner() {
        checkOwner();
        _;
    }

    function checkOwner() internal;
}

/**
 * @title OwnableImpl
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract OwnableImpl is Ownable {
    address public owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev The Ownable constructor sets the original `owner` of the contract to the sender
     * account.
     */
    function OwnableImpl() public {
        owner = msg.sender;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    function checkOwner() internal {
        require(msg.sender == owner);
    }

    /**
     * @dev Allows the current owner to transfer control of the contract to a newOwner.
     * @param newOwner The address to transfer ownership to.
     */
    function transferOwnership(address newOwner) onlyOwner public {
        require(newOwner != address(0));
        OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}

contract EtherReceiver {
	function receiveWithData(bytes _data) payable public;
}

contract Forwarder is OwnableImpl {
	function withdraw(address to, uint256 value) onlyOwner public {
		to.transfer(value);
	}

	function forward(address to, bytes data) payable public {
		uint256 commission = msg.value / 100;
		EtherReceiver(to).receiveWithData.value(msg.value - commission)(data);
	}
}