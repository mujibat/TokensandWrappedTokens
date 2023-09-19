// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;
//import {ERC20} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
interface ILMAO {
    function transfer(address to, uint256 value) external returns (bool success);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}
contract LMAOToken is ERC20 {

    address deployer;

    constructor() ERC20("LMAOTOK", "LMOT"){
        _mint(msg.sender, 1_000_000e18);
        deployer = msg.sender;
    }

    mapping(address=> uint) _chargesAccount;
    
   
    function balanceOf(address _lmaotoken) public view override returns (uint256){
        return _chargesAccount[_lmaotoken];
    }
    
    // function transfer(address _to, uint256 _tokenamount) public virtual override returns (bool) {
    //       uint deductLMAOToken = _tokenamount * 8 / 100;
    //       uint getLMAOToken = _tokenamount - deductLMAOToken;
    //     address owner = msg.sender;
    //     _transfer(owner, _to, getLMAOToken);
    //     _transfer(owner, deployer, deductLMAOToken);
    //     return true;
    // }
    //   function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
    //     address spender = _msgSender();
    //     _spendAllowance(from, spender, amount);
    //     uint deductLMAOToken = amount * 8 / 100;
    //       uint getLMAOToken = amount - deductLMAOToken;
    //     _transfer(from, to, getLMAOToken);
    //     _transfer(from, deployer, deductLMAOToken);
    //     return true;
    // }
     function _transfer(address from, address to, uint256 amount) internal virtual override {
          uint deductLMAOToken = amount * 8 / 100;
          uint getLMAOToken = amount - deductLMAOToken;
          super._transfer(from, to, getLMAOToken);
        super._transfer(from, deployer, deductLMAOToken);
     }


}


contract WrappedLMAOToken is ERC20 {

    address lmaotoken;

     constructor(address _lmaotoken) ERC20("WRAPLTOK", "WLMAOT"){
        _mint(msg.sender, 1_000_000e18);
        lmaotoken = _lmaotoken;
    }

    address owner;
    
    mapping(address=> uint) balances;
   

    function depositLMAOtoWLMAO(uint _LMAOamount, address _to) external payable  {
         require(_LMAOamount > 0, "Amount to deposit must be greater than 0");
          uint deductLMAOTokenFee = _LMAOamount * 8 / 100;
        uint getWLMAOToken = _LMAOamount - deductLMAOTokenFee;
        
         ILMAO(lmaotoken).transfer(owner, _LMAOamount);
        _mint(_to, getWLMAOToken);
        balances[_to] += getWLMAOToken;

    }
   
   
    function withdrawWLMAO(uint _amount, address _to) external {
         require(balances[_to] >= _amount, "Insufficient balance");
        balances[_to] -= _amount;
        payable(msg.sender).transfer(_amount);
        
     }
}

