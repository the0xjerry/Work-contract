// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 < 0.9.0;

contract Agreement {
    address owner;
    uint Funds;
    bool agreed;
    
    constructor () payable {
        owner = msg.sender; // owner = msg.sender and this refers to the person who calls the smart contract.meaning the owner is actually the smart contract caller (msg.sender)
        Funds = msg.value; 
        agreed = false; // agreed is a boolean (true or false) that checks whether or not an agreement has been reached, which determines the execution pf the smart contract.
    }


    // modifiers are add-ons that help creates additional logic for functions
    
    // onlyOwner is just a title given to our modifier so, it can be use later on.
    modifier onlyOwner {
        require (msg.sender == owner); // require is basically a conditional statement. example; 
        // for something to be true, ITS HAS TO BE (==) valid. So, the require statement we see, says that msg.sender HAS TO BE EQUAL (==) OWNER 
        // the function (modifier) requires MSG.SENDER TO BE EQUAL (==) OWNER
        _; 
        
    }

     modifier mustBeAgreed {
         require ( agreed == true);
         _;  
     }
     
     address payable [] paymentWallets; // This is an array ( an array is a list of items either strings or uints)  of paymentWallets.
     
     mapping (address => uint) Money; // mapping meaing we are looing throgh the Owners address into the 
     
     function setFunds (address payable wallet, uint amount) public onlyOwner {
         paymentWallets.push(wallet);
         Money [wallet] = amount;
     }
     
     // payout funtion 
     function payout () private mustBeAgreed {
         for (uint i=0; i<paymentWallets.length; i++) {
             paymentWallets[i].transfer ( Money[paymentWallets[i]]); 
         }
     }

     // This is a function or an oracle i think, hat checks and conclude if the agreement is true before the payout function is excuted by the owner
     function isAgreed () public {
         agreed = true; 
         payout (); // this is the called function that pays oyt the Funds to the paymentWallets if the agreed = true
     }
}   

// kay was here