// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.6.12 <0.9.0;

contract Log {
    struct logInfo{
        address actorId;
        string operation;
        string[] personalData;
        string serviceName;

    }
    logInfo [] logs;
    function setLog(address actorId, string memory operation, string[] memory personalData, string memory serviceName)public {
        logInfo memory log;
        log.actorId = actorId;
        log.operation = operation;
        log.personalData = personalData;
        log.serviceName = serviceName;
        logs.push(log);

    }
    function getLogByActorId(address actorId) public view returns (logInfo memory log){
        for(uint i = 0; i < logs.length; i++){
            if(logs[i].actorId == actorId){
                return logs[i];
            }
        }
    }
    function getlogs() public view returns (logInfo [] memory log){
        return logs;
    }
   
    function updateLog(address actorId, string memory operation) public {
    for (uint i = 0; i < logs.length; i++) {
        if (logs[i].actorId == actorId) {
            logs[i].operation = string(abi.encodePacked(logs[i].operation, operation));
            break; 
        }
    }
}

    
}