pragma solidity ^0.4.18;

contract MiThaCoin {

    string public constant name = "MiThaCoin";
    string public constant symbol = "MTC";
    uint public constant decimals = 18;

    // create a table to map address to its balance
    mapping (address => uint) balances;

    // create a table to map address of contract owner
    // to addressese that are allowed to utilize the owner's contract
    mapping (address => mapping (address => uint)) allowed;

    // total supply of this contract, don't allow to change here
    uint _totalSupply = 1000000000000000000000000000000; // 10^12 (decimals 10^18)

    // owner of the contract
    address public owner;

    constructor() public {
        owner = msg.sender;
        balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner of the contract can call this function");
        _;
    }

    // Implementing all standard ERC20 functions
    function totalSupply() public view returns (uint tokenTotalSupply) {
        tokenTotalSupply = _totalSupply;
        return tokenTotalSupply;
    }

    function balanceOf(address _owner) public view returns (uint balance) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        if (_value > 0 && balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            emit Transfer(msg.sender, _to, _value);
            return true;
        }
        return false;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        if (_value > 0 && balances[_from] >= _value && balances[_to] + _value > balances[_to]) {
            balances[_from] -= _value;
            balances[_to] += _value;
            emit Transfer(_from, _to, _value);
            return true;
        }
        return false;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // return allowance
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

    // Triggered whenever approve(address _spender, uint256 _value) is called.
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    // Triggered when tokens are transferred.
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
}