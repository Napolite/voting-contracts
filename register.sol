// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/utils/Strings.sol";

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

interface registerVoter{
    function registerDetails(string calldata name, uint age) external;
    function applyToVote(string calldata name, uint age, string calldata voterID, address voterAddress) external;
    function confirmApplication() external view returns (string memory);
    function grantRgihtToVote() external;
    function getDetails() external view returns (voter memory);
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

    address public electionCordinator;
    address public contractOwner;
    uint regCount;
    mapping( address => voter) public voters;

    constructor(){ 
        contractOwner = msg.sender;
        regCount = 1;
    }

    function registerDetails(string calldata name, uint age) public returns (voter memory) {
        require(age > 17, "not eligible to vote");
        require(voters[msg.sender].age == 0, "This address has been registered");

        string memory voterID = string.concat("NIG",Strings.toString(regCount));

        voters[msg.sender] = voter(name, age, voterID,false);

        regCount += 1;

        return voters[msg.sender];
    }

    // function applyToVote(string calldata name, uint age,)


}