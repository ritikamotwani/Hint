pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import 'zeppelin-solidity/contracts/token/StandardToken.sol';
import 'zeppelin-solidity/contracts/math/SafeMath.sol';

interface ERC20 {
    function transferFrom(address _from, address _to, uint _value) public returns (bool);
    function approve(address _spender, uint _value) public returns (bool);
    function allowance(address _owner, address _spender) public constant returns (uint);
    event Approval(address indexed _owner, address indexed _spender, uint _value);
}

interface ERC223 {
    function transfer(address _to, uint _value, bytes _data) public returns (bool);
    event Transfer(address indexed from, address indexed to, uint value, bytes indexed data);
}

contract Token {
	uint internal _totalSupply = 0;
	uint internal _raiseAmount = 0;
	mapping (address => uint) paid;
	struct Transaction {
 		string name;
		uint amount;
	}
	string promisedWork;
	struct completedTransaction {
		string work = "";
		uint amount;
	}
	Transaction transactions[];    
	completedTransaction trans;
}

contract userToken is Token, Ownable, ERC20, ERC223 {   		
	function donate(string _name, uint _value) public{
		transactions.push(Transaction(_name, _value);		
		paid[msg.sender] = paid[msg.sender]+_value;
		_totalSupply = _totalSupply+value;
	}
	function donatedMoney() return (uint amount) {
		amount = paid[msg.sender];
		return amount;
	}
	function check() returns (string work, uint amount){
		work = trans.work;
		if(work == "") {
			work =	"Week isn't over yet.";
		}		
		amount = trans.amount;
		return (work,amount);
	}
	event WorkDone();
	event WorkNotDone();
	function useCharity() {
		if(_totalSupply >= _raiseAmount) {
			uint amount = _raiseAmount;
			_totalSupply = _totalSupply - _raiseAmount;
			string work =  promisedWork;
			trans = completedTransaction(work,amount);
			WorkDone;
		}
		else {
			string work = "Goal forwarded next week.";
			amount = 0;
			trans = completedTransaction(work,amount);
			WorkNotDone();
		}
	}
	function setGoal(string _work, uint _amount) {
		promisedWork = _work;
		_raiseAmount = _amount;
	}
}

