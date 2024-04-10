// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Agreement{
    struct UserVote {
        bytes32 hashAddressPurpose;
        address userId;
        bool consent;
        address actorId;
        string operation;
        string[] processedPersonalData;
   }

    UserVote[] public userVote;
    mapping(address => mapping(address => UserVote[])) public actorUserVote;
      
    function addAgreement(bytes32 _hashAddressPurpose, address _userId, bool _consent, address _actorId,string memory _operation,
    string[] memory _processedPersonalData) public {
         UserVote memory userConsent = UserVote({
         hashAddressPurpose: _hashAddressPurpose,
         userId: _userId,
         consent: _consent,
         actorId: _actorId,
         operation: _operation,
         processedPersonalData: _processedPersonalData
        });
        userVote.push(userConsent);
        actorUserVote[_actorId][_userId].push(userConsent);
    }
    
    function getAgreementCount() public view returns (uint256) {
        return userVote.length;
    }
    
    function getAgreement(uint256 index) public view returns (bytes32 hashAddressPurpose, address userId, bool consent) {
        require(index < userVote.length, "Agreement index out of range");
        UserVote storage  usrVote = userVote[index];
        return (usrVote.hashAddressPurpose, usrVote.userId, usrVote.consent);
    }

       function getAgreementByActorID(address _actorId, address _userId) external view returns ( UserVote[] memory userConsent) {
        UserVote[] storage  usrVote = actorUserVote[_actorId][_userId];
        return usrVote;
    }
}
