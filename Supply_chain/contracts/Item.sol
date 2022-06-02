// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
import "./ItemManager.sol";

contract Item {
    uint public priceInWei;
    uint public index;
    uint public pricePaid;

    ItemManager parentContract;

    constructor(ItemManager _parentContract, uint _priceInWei, uint _index) {
        priceInWei  = _priceInWei;
        index = _index;
        parentContract = _parentContract;
    }

    receive() external payable {
        // address(parentContract).call.value(msg.value);    // this is a high level function so to use more gas we have to use low level calls
        require(pricePaid == 0, "Item is paid already");
        require(priceInWei == msg.value, "Only full payments allowed");
        pricePaid += msg.value;
        
        // main function which is used for the payment of the item can be done by using the item index
        (bool _success, ) = address(parentContract).call{value:msg.value}(abi.encodeWithSignature("triggerPayment(uint)",index));
        require(_success, "The transaction wasn't successful, cancelling");
    }

    fallback() external{
        
    }
    



}