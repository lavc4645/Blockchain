// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

contract Player {
    address payable public  player1;
    uint public balanceOfPlayer1;
    address payable public  player2;
    uint public balanceOfPlayer2;

    mapping(address => bool) public approvers;

    event PlayerAccount2_setup(address _player);
    event PlayerAccount1_setup(address _player);
    event BalanceRedeemed(address _player, uint _balance);

    modifier onlyApproved() {
        require(approvers[msg.sender],"You are not authorized");
        _;
    }
    
    function setPlayerAccount(address _player) public {
        require(player1 == address(0) || player2 == address(0), "Players already registered"); 
        if(player1 == address(0)) {
            player1 = payable(_player);
            approvers[_player]= true;
            emit PlayerAccount1_setup(_player);
        }

    else{
        player2 = payable(_player);
            approvers[_player]= true;
        emit PlayerAccount2_setup(_player);
    }
}
    

    function redeem_balance(address payable _player) payable public onlyApproved() {
        require(_player == player1 || _player == player2, "You are not authorized to redeem the transaction only players are allowed");
        if(_player == player1){
        _player.transfer(balanceOfPlayer1);
        balanceOfPlayer1 -= balanceOfPlayer1;
        emit BalanceRedeemed(_player,balanceOfPlayer1);
        }

        else{
        _player.transfer(balanceOfPlayer1);
        balanceOfPlayer1 -= balanceOfPlayer1;
        emit BalanceRedeemed(_player,balanceOfPlayer2);

        }
    }


}