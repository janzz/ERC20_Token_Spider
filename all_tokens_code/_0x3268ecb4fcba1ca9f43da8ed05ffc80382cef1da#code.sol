//token_name	
//token_url	https://etherscan.io//address/0x3268ecb4fcba1ca9f43da8ed05ffc80382cef1da#code
//spider_time	2018/07/08 12:45:13
//token_Transactions	6 txns
//token_price	

pragma solidity ^0.4.0;

contract Ownable {
  address owner;
  function Ownable() {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }
}

contract AddressLottery is Ownable{
    struct SeedComponents{
        address addr;
        uint additionalSeed1;
        uint additionalSeed2;
        uint additionalSeed3;
    }
    
    uint luckyNumber = 13;
    uint private secretSeed;
    mapping (address => bool) participated;


    function AddressLottery() payable {
        reseed(SeedComponents(msg.sender, 0x12345678, 0x123456789, uint256(block.blockhash(block.number - 1))));
    }
    
    function participate() payable { 
        require(msg.value == 0.1 ether);
        
        // every address can only win once, obviously
        require(!participated[msg.sender]);
        
        if ( luckyNumberOfAddress(msg.sender) == luckyNumber)
        {
            participated[msg.sender] = true;
            require(msg.sender.call.value(this.balance)());
        }
    }
    
    function luckyNumberOfAddress(address addr) internal returns(uint n){
        // 1 in 16 chance
        n = uint(keccak256(addr, secretSeed)[0]) % 16;
    }
    
    function reseed(SeedComponents components) internal{
        secretSeed = uint256(keccak256(components.addr, components.additionalSeed1, components.additionalSeed2, components.additionalSeed3));
    }
    
    function kill() onlyOwner {
        suicide(owner);
    }
    
    function forceReseed() onlyOwner{
        SeedComponents s;
        s.addr = msg.sender;
        s.additionalSeed1 = tx.gasprice * 13;
        s.additionalSeed2 = block.number * 7;
        s.additionalSeed3 = uint256(block.blockhash(block.number - 1));
        reseed(s);
    }
    
    function () payable {}
}