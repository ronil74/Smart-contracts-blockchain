// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 <0.9.0;

contract DataUsageSMContract {
    
    address myActorId;

    struct DataUsage {
        address actorId;
        string serviceName;
        string servicePurpose;
        string operation;
        string[] personalData;
    }
     
    mapping(address => DataUsage[]) public dataUsageArray;

   function addActor(address actorId, string memory serviceName, string memory servicePurpose, string memory operation, string[] memory personalData) public {
        DataUsage memory actor;
        actor.actorId = actorId;
        actor.serviceName = serviceName;
        actor.servicePurpose = servicePurpose;
        actor.operation = operation;
        actor.personalData = personalData;
        dataUsageArray[actorId].push(actor);
        myActorId = actorId;
    }
    
     
    function getDataUsageCount(address actorId ) public view returns (uint256) {
        return dataUsageArray[actorId].length;
    }
    
    function getDataUsageByActorId(address actorId) public view returns (DataUsage[] memory details) {
        return dataUsageArray[actorId];
    }

    function getCurrentBlockHash() public view returns (bytes32) {
        return blockhash(block.number-1);
    }

}