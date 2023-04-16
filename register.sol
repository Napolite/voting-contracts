// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface registerVoter{
    function registerDetails(string calldata name, uint age) external;
    function applyToVote(string calldata name, uint age, string calldata voterID, address voterAddress) external;
    function confirmApplication() external;
    function giveRgihtToVote() external;
}

interface registerAdmin{
    function applyForAdmin(string calldata name, string calldata electionID, address voterAddress) external;
    function isElectionCoord(string calldata electionID) external view returns (bool);
    function grantAdminPrivileges(string calldata electionID) external;
    function transferAdminAuth(string calldata electionID, address from, address to,bool isElectionCoord) external;
    function withdrawAdminPrivileges(string calldata electionID, string calldata adminID, bool isElectionCoord) external;
    function isVoter(string calldata voterID) external returns (bool);
}



contract Voter{

    struct voter{
        string name;
        uint age;
        string voterID;
        bool hasRightToVote;
    }

    struct coordinator{
        string name;
        string cordID;
        string electionID;
        bool adminAuth;
    }

    address public electionCordinator;
    address public contractOwner;
    mapping( address => voter) public voters;

    constructor(){ 
        contractOwner = msg.sender;
    }

    function registerDetails(string calldata name, uint age) public{
        require(age > 18, "not eligible to vote");

        voters[msg.sender] = voter(name, age, "",false);
    }

}