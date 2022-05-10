// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

contract Player1 {
    address payable public  player1;
    address public player1_contract_address;

    event BalanceRedeemedOfplayer1(uint _balance);

    constructor(){
        player1 = payable(msg.sender);
        player1_contract_address = address(this);

    }

    function redeem_balanceOfplayer1() payable public {
        player1.transfer(address(this).balance);
        emit BalanceRedeemedOfplayer1(address(this).balance);
    }

    function checkbalanceOfplayer1() public view returns(uint){
        return (address(this).balance);

    }

}