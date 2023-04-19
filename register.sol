// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/utils/Strings.sol";

struct voter{
        string name;
        uint age;
        string voterID;
        bool canApplyToVote;
        address voterAddress;
    }

struct coordinator{
        string name;
        string cordID;
        string electionID;
        bool adminAuth;
        address voterAddress;
    }

interface registerVoter{
    function registerDetails(string calldata name, uint age) external returns(voter memory);
    function confirmApplication() external view returns (bool);
    function getDetails() external view returns (voter memory);
}

interface registerAdmin{
    function applyForAdmin(string calldata name, string calldata electionID) external;
    function isElectionCoord(string calldata electionID) external view returns (bool);
    function grantAdminPrivileges(string calldata electionID) external;
    function transferAdminAuth(string calldata electionID, address from, address to,bool isElectionCoord) external;
    function withdrawAdminPrivileges(string calldata electionID, string calldata adminID, bool isElectionCoord) external;
    function isVoter(string calldata voterID) external returns (bool);
}

interface Admin{
    function grantRgihtToVote (address voterAddress) external;
    function grantApplicationRight (address voterAddress) external;
    function revokeApplication(address voterAddress) external;
    function blacklistVoter(address voterAddress) external;
    function whitelistVoter(address voterAddress) external;
}



contract Voter is registerVoter{

    address public electionCordinator;
    address public contractOwner;
    uint regCount;
    mapping( address => voter) public voters;
    mapping(address => coordinator) public coordinators;
    

    constructor(){ 
        contractOwner = msg.sender;
        regCount = 1;
    }

    modifier onlyAdmin{
        require (coordinators[msg.sender].adminAuth == true);
         _;
    }

    function registerDetails(string calldata name, uint age) public returns (voter memory) {
        require(age > 17, "not eligible to vote");
        require(bytes(voters[msg.sender].voterID).length == 0, "This address has been registered");

        string memory voterID = string.concat("NIG",Strings.toString(regCount));

        voters[msg.sender] = voter(name, age, voterID,false, msg.sender);

        regCount += 1;

        return voters[msg.sender];
    }


    function confirmApplication() public view returns(bool){
        return voters[msg.sender].canApplyToVote;
    }

    function getDetails() public view returns (voter memory){
        return voters[msg.sender];
    }

    function applyForAdmin(string calldata name, string calldata electionID) public{
        require(bytes(coordinators[msg.sender].cordID).length == 0, "This address is an admin");
        require(bytes(voters[msg.sender].voterID).length != 0, "This address has mot been registered in the electoral process");

        string memory cordID = string.concat("COD",Strings.toString(regCount));
        voters[msg.sender].voterID = '';
        coordinators[msg.sender]= coordinator(name,cordID,electionID,false, msg.sender );
    }


}