pragma solidity ^0.4.25;

import "./TokenSpec.sol";

contract Transactions is FairChainToken {
    
    uint public NAV = 1000000000; //unité : millième d'euro, un wei ici
    uint public NAVunitaire ; 
    uint public ecartNAV = 20; //%
    uint public lastSentEther;
    uint public buyPrice;
    
    constructor() public payable {
        NAVunitaire = (NAV*1000) / totalSupply(); // multiplication par 1000 car token divisible
        buyPrice = safeDiv(NAVunitaire*(100+ecartNAV),100);
        lastSentEther = msg.value;
    }
    

    function buyXtoken(uint X) payable public returns(bool success) {
        require(msg.value == buyPrice*X, "wrong amount sent");
        transferModified(msg.sender, X);
        lastSentEther = msg.value; // stocker dans un array pour avoir les ordres (valeur et nbr)
        return true;
    }
    
    function buyByAmount() payable public returns(bool success) {
        require(msg.value % buyPrice == 0);
        transferModified(msg.sender, safeDiv(msg.value, buyPrice));
        lastSentEther = msg.value;
        return true;
    }
}
