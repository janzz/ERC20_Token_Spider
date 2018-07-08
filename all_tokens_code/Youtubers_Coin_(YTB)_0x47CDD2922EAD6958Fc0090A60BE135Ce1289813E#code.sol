//token_name	Youtubers_Coin_(YTB)
//token_url	https://etherscan.io//address/0x47CDD2922EAD6958Fc0090A60BE135Ce1289813E#code
//spider_time	2018/07/08 12:16:54
//token_Transactions	6 txns
//token_price	

pragma solidity ^0.4.8;

interface ERC20Interface {

    function totalSupply() constant returns (uint256 totalSupply) ;
    
    function balanceOf(address _owner) constant returns (uint256 balance);
    
    function transfer(address _to, uint256 _value) returns (bool success);
    
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success);
    
    function approve(address _spender, uint256 _value) returns (bool success);
    
    function allowance(address _owner, address _spender) constant returns (uint256 remaining);
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
 }
  
 contract YoutubersCoin is ERC20Interface {
      string public constant symbol = "YTB";
      string public constant name = "Youtubers Coin";
      uint8 public constant decimals = 8;
      uint256 _totalSupply = 10000000000000000000;
 
      address public owner;
   
      mapping(address => uint256) balances;
   
 
      mapping(address => mapping (address => uint256)) allowed;
   
      
      modifier onlyOwner() {
          if (msg.sender != owner) {
              throw;
          }
          _;
      }
   
      function YoutubersCoin() {
          owner = msg.sender;
          balances[owner] = _totalSupply;
      }
   
      function totalSupply() constant returns (uint256 totalSupply) {
          totalSupply = _totalSupply;
      }
   
      function balanceOf(address _owner) constant returns (uint256 balance) {
          return balances[_owner];
      }
   
      function transfer(address _to, uint256 _amount) returns (bool success) {
          if (balances[msg.sender] >= _amount 
              && _amount > 0
              && balances[_to] + _amount > balances[_to]) {
              balances[msg.sender] -= _amount;
              balances[_to] += _amount;
              Transfer(msg.sender, _to, _amount);
              return true;
          } else {
              return false;
          }
      }
   
      function transferFrom(
          address _from,
          address _to,
          uint256 _amount
     ) returns (bool success) {
         if (balances[_from] >= _amount
             && allowed[_from][msg.sender] >= _amount
             && _amount > 0
             && balances[_to] + _amount > balances[_to]) {
             balances[_from] -= _amount;
             allowed[_from][msg.sender] -= _amount;
             balances[_to] += _amount;
             Transfer(_from, _to, _amount);
             return true;
         } else {
             return false;
         }
     }

     function approve(address _spender, uint256 _amount) returns (bool success) {
         allowed[msg.sender][_spender] = _amount;
         Approval(msg.sender, _spender, _amount);
         return true;
     }
  
     function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
         return allowed[_owner][_spender];
     }
 }