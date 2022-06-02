// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

import "./GameNew.sol";

contract PlayerNew {

    address payable public player;
    // uint public bal;
    uint index;
    bool sent;
    uint hurdle_penality = 50000 wei;

    event Penality(bool _sent);

    GameNew parentcontract;

    event BalanceRedeemed(address _player, uint _balance);

    constructor(GameNew _parentcontract, address payable _player, uint _index) {
        player = _player;
        index = _index;
        parentcontract = _parentcontract;
    }

     function redeemAllBalance() payable public {
       
        emit BalanceRedeemed(player,address(this).balance);
        player.transfer(address(this).balance);
        }

        function hurdlePenality() public { 
             (sent, ) = address(parentcontract).call{value: hurdle_penality}("");
             emit Penality(sent);
             
        }

        

    fallback() external payable {
        
    }

}