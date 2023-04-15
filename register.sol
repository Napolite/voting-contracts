// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface registerVoter{
    function applyToVote(string name, string age, voterID, ) external;
    function confirmApplication() external;
    function giveRgihtToVote() external;
}

contract Voter{

    struct voter{
        string name;
        string age;
        string voterID;
        bool hasRightToVote;
    }

    struct coordinator{
        
    }

    address public electionCordinator;
}