// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenSwap {

    IERC20 public token1;
    address public owner1;
    uint public amount1;
    IERC20 public token2;
    address public owner2;
    uint public amount2;

    constructor (
        address _token1,
        address _owner1,
        uint _amount1,
        address _token2,
        address _owner2,
        uint _amount2
    ) {
        token1 = IERC20(_token1);
        owner1 = _owner1;
        amount1 = _amount1;
        token2 = IERC20(_token2);
        owner2 = _owner2;
        amount2 = _amount2;
    }

    function swap() public {
        require(msg.sender == owner1 || msg.sender == owner2, "Not authorized");
        require(
            token1.allowance(owner1, address(this)) >= amount1,
            "Token 1 allowance too low"
        );
        require(
            token2.allowance(owner2, address(this)) >= amount2,
            "Token 2 allowance too low"
        );

    //transfer tokens
    // tokenn 1, owner1, amount1 -> owner 2
    _safeTransferFrom(token1, owner1, owner2, amount1);
    // token 2, owner2, amount2 -> owner 1
    _safeTransferFrom(token2, owner2, owner1, amount2);

    }

    function _safeTransferFrom(
        IERC20 token,
        address sender,
        address recipient,
        uint amount
    ) private {
        bool sent = token.transferFrom(sender, recipient, amount);  
        require(sent, "Token transfer failed");
    }


}


//A 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// TA 0xd9145CCE52D386f254917e481eB44e9943F39138
//B 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
// TB 0xa131AD247055FD2e2aA8b156A11bdEc81b9eAD95
// TOKENSWAP 0x9ecEA68DE55F316B702f27eE389D10C2EE0dde84
// 10000000000000000000
// 20000000000000000000
