// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

import "./Player1.sol";
import "./Player2.sol";


contract Game is Player1, Player2{

    struct Player{
        address payable _address;
        uint _balance;
    }

    mapping(uint => Player) public players ;
    mapping(address => bool) public approvers;

    address payable public owner;
    address public contract_address;
    // uint amt_transfer_to_contract = 10 ether;
    uint hurdle_winning_amt = 1 ether;
    uint reward = 2 ether;
    bool public gameOver;
    bool public gamePause;
    bool public sent;


    constructor() payable {
        owner = payable(msg.sender);
        contract_address = address(this);
        (sent, ) = address(this).call{value: msg.value}("");

    }

    event Money_Transfered_to_contract();
    event GameStarted();
    event Player1Joined(address payable player, uint _balance);
    event Player2Joined(address payable player, uint _balance);

    modifier onlyApproved() {
        require(isOwner() || approvers[msg.sender],"You are not authorized");
        _;
    }

    function isOwner() internal view returns (bool) {
        return msg.sender == owner;
    }

    function start_the_game() public{
        require(players[0]._address != address(0) && players[1]._address != address(0));
        require(!gameOver && !gamePause, "Game has already stated");
        emit GameStarted();
    }


    function setPlayerAccount1() public{
        require(players[0]._address == address(0),"Player1 is already joined");
        players[0]._address = payable(Player1.player1_contract_address);
        approvers[players[0]._address] = true;
        emit Player1Joined(players[0]._address, players[0]._balance);
    }
    
     function setPlayerAccount2() public {
        require(msg.sender != players[0]._address,"Player already registered");
        require(players[1]._address == address(0),"Player2 is already exist" );
        players[1]._address = payable(Player2.player2_contract_address);
        approvers[players[1]._address] = true;
        emit Player2Joined(players[1]._address, players[1]._balance);
     }

    

    function hurdle_passed(address payable _player) public onlyApproved() {
        require(!gameOver && !gamePause, "Game has already stated");
        _player.transfer(hurdle_winning_amt);
        
    }

    function levelUp(address payable _player) public onlyApproved() {
        require(!gameOver && !gamePause, "Game has already stated");
        _player.transfer(reward);
        
       
    }


    function checkbalance() public view returns(uint){
        return (address(this).balance);

    }

}