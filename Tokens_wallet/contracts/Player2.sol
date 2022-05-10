// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

contract Player2 {
    address payable public  player2;
    address public player2_contract_address;

    event BalanceRedeemedOfplayer2(uint _balance);


    constructor(){
        player2 = payable(msg.sender);
        player2_contract_address = address(this);

    }

    function redeem_balanceOfplayer2() payable public {
        player2.transfer(address(this).balance);
        emit BalanceRedeemedOfplayer2(address(this).balance);
    }

    function checkbalanceOfplayer2() public view returns(uint){
        return (address(this).balance);

    }

}