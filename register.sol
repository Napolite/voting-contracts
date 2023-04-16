// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface registerVoter{
    function applyToVote(string calldata name, string calldata age, string calldata voterID, address voterAddress) external;
    function confirmApplication() external;
    function giveRgihtToVote() external;
}

interface registerAdmin{
    function applyForAdmin(string calldata name, string calldata electionID, address voterAddress) external;
    function isElectionCoord(string calldata electionID) external view returns (bool);
    function grantAdminPrivileges(string calldata electionID) external;
    function transferAdminAuth(string calldata electionID, address from, address to,bool isElectionCoord) external;
    function withdrawAdminPrivileges(string calldata electionID, string calldata adminID, bool isElectionCoord) external;
}

contract Voter{

    struct voter{
        string name;
        string age;
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
}