// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

import "./Player1.sol";


contract Game is Player{

    // struct Player{
    //     address payable _address;
    //     uint _balance;
    // }

    mapping(uint => Player) public players ;
    // mapping(address => bool) public approvers;

    address payable public owner;
    address public contract_address;
    // uint amt_transfer_to_contract = 10 ether;
    uint hurdle_winning_amt = 10000 wei;
    uint reward = 100000;
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

    // modifier onlyApproved() {
    //     require(isOwner(),"You are not authorized");
    //     _;
    // }

    function isOwner() internal view returns (bool) {
        return msg.sender == owner;
    }

    function start_the_game() public{
        require(!gameOver && !gamePause, "Game has already stated");
        emit GameStarted();
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