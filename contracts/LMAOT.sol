// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;
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
     function _transfer(address from, address to, uint256 amount) internal virtual override {
          uint deductLMAOToken = amount * 8 / 100;
          uint getLMAOToken = amount - deductLMAOToken;
          super._transfer(from, to, getLMAOToken);
        super._transfer(from, deployer, deductLMAOToken);
     }
}
contract Wlmao is ERC20 {
    

    ILMAO LmaoContract;
    constructor(address lmao)ERC20("WRAPLTOK", "WLMAOT"){
        LmaoContract = ILMAO(lmao);
    }

    function depositlmao(uint lmaoamount) external {
        LmaoContract.transferFrom(msg.sender, address(this), lmaoamount);
        uint amountToMint = lmaoamount * 92 /100;

        _mint(msg.sender, amountToMint);
    }

    function Withdraw(uint _amount) external {
        require(_amount <= balanceOf(msg.sender), "Insufficient");
        _burn(msg.sender, _amount);
        LmaoContract.transfer(msg.sender, _amount);
    }
}
