// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

import "./PlayerNew.sol";

 contract GameNew{

     enum GameState{Start, Stop, Pause}
     struct Player{
         PlayerNew _player;
        //  GameNew.GameState _state;
     }

     event PlayerJoined(uint _index,address _player);
     event TransferComplete(bool _sent);
     event GameStarted(GameState _state);
     event GamePaused(GameState _state);
     event GameStopped(GameState _state);

     mapping(uint => Player) public players;
     mapping(address => bool) public approvers;

     GameState public _state;
     uint playerIndex = 1;
     uint hurdle_reward = 100000 wei;
     uint levelup_reward = 5000000 wei;
     bool sent;
     bool sent1;
     address payable public owner;
     address public contract_address;

     modifier onlyApproved() {
        require(isOwner() || approvers[msg.sender],"You are not authorized");
        _;
    }

    function isOwner() internal view returns (bool) {
        return msg.sender == owner;
    }



    constructor() payable {
        owner = payable(msg.sender);
        contract_address = address(this);
        (sent1, ) = address(this).call{value: msg.value}("");

    }

    function startGame() onlyApproved() public {
        require(msg.sender == owner, "You are not allowed");
        _state = GameState.Start;
        emit GameStarted(_state);
    }

     function pauseGame() onlyApproved() public {
        _state = GameState.Pause;
        emit GamePaused(_state);
    }

     function stopGame() onlyApproved() public {
        require(msg.sender == owner, "You are not allowed");
        _state = GameState.Stop;
        emit GameStopped(_state);
    }


     function setPlayerAccount(address payable player_) public{
        require(_state == GameState.Pause || _state == GameState.Start, "Game is not in running condition");
        PlayerNew _player = new PlayerNew(this, player_, playerIndex );
        players[playerIndex]._player = _player;
        approvers[address(_player)] = true;
        emit PlayerJoined(playerIndex, address(_player));
        playerIndex++;
     }

     function CheckBalance(address _player) view public onlyApproved() returns(uint) {
         return(_player.balance);
     }

    function hurdlePassed(uint _playerIndex) public onlyApproved() returns(uint) {
        require(_state == GameState.Start, "Game is not in running condition");
        (sent, ) = address(players[_playerIndex]._player).call{value: hurdle_reward}("");
        emit TransferComplete(sent);
        return(address(players[_playerIndex]._player).balance);


    }

    function levelUp(uint _playerIndex) public onlyApproved() returns(uint) {
        require(_state == GameState.Start, "Game is not in running condition");
        (sent, ) = address(players[_playerIndex]._player).call{value: levelup_reward}("");
        emit TransferComplete(sent);
        return(address(players[_playerIndex]._player).balance);


    }

    function withdrawAllAmount(uint _playerIndex) public onlyApproved() {
        require(_state == GameState.Stop, "Game is running, Please Try after game stopped");
        (players[_playerIndex]._player).redeemAllBalance();
    }

    function hurdleFail(uint _playerIndex) payable public onlyApproved() {
        require(_state == GameState.Start, "Game is not in running condition");
        (players[_playerIndex]._player).hurdlePenality();
    }

    fallback() payable external{

    }
     
}