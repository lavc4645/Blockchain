// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;
import "./GameNew.sol";

contract PlayerNew {

    address payable public player;
    // uint public bal;
    uint index;
    bool sent;
    uint hurdle_penality = 50000 wei;

    event Penality(bool _sent);

   GameNew parentcontract;

    event BalanceRedeemed(address player, uint balance);
    function setNewPlayer(GameNew _parentcontract, address payable _player, uint _index) public {
        player = _player;
        index = _index;
        parentcontract = _parentcontract;
    }

     function redeemAllBalance() payable public {
       
        emit BalanceRedeemed(player,address(this).balance);
        player.transfer(address(this).balance);
        }    

    // fallback() external payable {
        
    // }

}