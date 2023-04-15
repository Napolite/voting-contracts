// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface registerVoter{
    function applyToVote(string calldata name, string calldata age, string calldata voterID, address voterAddress) external;
    function confirmApplication() external;
    function giveRgihtToVote() external;
}

interface registerAdmin{
    function applyForAdmin(string calldata name, string calldata electionID, address voterAddress) external;
}

contract Voter{

    struct voter{
        string name;
        string age;
        string voterID;
        bool hasRightToVote;
    }

    // struct coordinator{

    // }

    address public electionCordinator;
}