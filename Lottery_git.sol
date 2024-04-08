//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Lottery{
    //entities or variables created
    address payable[] public players;
   
    address public manager;


//manager will deploy contract
    constructor(){// global variable h
        manager = msg.sender;
    }
   
    receive ()  external payable{
        require(msg.value >= 1 ether);//used to check criteria(if ele type)
        players.push(payable(msg.sender));//trnasfer add of participant
    }

    function getBalance() public view returns(uint){
        require(msg.sender == manager);
        return address(this).balance;
    }
    //selecting participants
    function random() public  view returns(uint){
       
       return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }
//to select winner

    function pickWinner() public{

        require(msg.sender == manager);//winner selected by manager only
        require (players.length >= 3);

        uint r = random();
        address payable winner;


        uint index = r % players.length;
        

       winner = players[index];
     // return winner;
 
     winner.transfer(getBalance());//to transfer all fund of contract to the winner


        players = new address payable[](0);
        
    }

}
