// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

contract SharedTokenWallet{

    mapping(address => uint) public tokenBalance;
    mapping(address => bool) public approvers;

    uint tokenPrice = 10000000000000 wei;

    address payable public owner;
    address public player1;
    address public player2;

    constructor(){
        owner = payable(msg.sender);
        tokenBalance[owner] = 1000;

    }

    modifier onlyApproved() {
        require(isOwner() || approvers[msg.sender],"You are not authorized");
        _;
    }

    function isOwner() internal view returns (bool) {
        return msg.sender == owner;
    }
    
    function setPlayerAccount1() public returns(string memory){
        if(player1 == address(0)  ){
            player1 = msg.sender;
            approvers[player1] = true;
            return("Player1 is ready.");
        }
        else{
            return("Player1 is already exist.");
        }
    }
    
     function setPlayerAccount2() public returns(string memory){
        require(msg.sender != player1,"Player already registered");
        if(player2 == address(0) ){
            player2 = msg.sender;
            approvers[player2] = true;
            return("Player2 is ready.");
        }
        else{
            return("Player2 is already exist.");
        }
    }

    function purchaseToken() public payable onlyApproved() returns(string memory, uint)  {

        // require(msg.sender == player1 || msg.sender == player2,"You are not authorized player" );
        require((tokenBalance[owner] * tokenPrice) / msg.value > 0, "not enough tokens" );
        if(msg.sender == player1){
            tokenBalance[owner] -= msg.value / tokenPrice;
            tokenBalance[player1] += msg.value / tokenPrice;
            owner.transfer(msg.value);
            return("Player1 have purchased",tokenBalance[player1]);

        }

        else if(msg.sender == player2){
            tokenBalance[owner] -= msg.value / tokenPrice;
            tokenBalance[player2] += msg.value / tokenPrice;
            owner.transfer(msg.value);
            return("Player1 have purchased",tokenBalance[player2]);
        }

        else{
            return("Player not authorised so no purchase happen", tokenBalance[msg.sender]);
        }


    }

    function point(address _winner, address _looser) public onlyApproved() {

        require(tokenBalance[_looser] >= 1, "Not enough tokens");
        assert(tokenBalance[_winner] + 1 > tokenBalance[_winner]);
        assert(tokenBalance[_looser] - 1 <= tokenBalance[_looser]);
        tokenBalance[_looser] -= 1;
        tokenBalance[_winner] += 1;
    }

    function levelUp(address _winner) public onlyApproved() {
        require(tokenBalance[owner] > 10,"Not enough token");

        tokenBalance[owner] -= 10;
        tokenBalance[_winner] +=10;
    }

    function checkbalance() public view returns(uint){
        return (address(this).balance);

    }

}