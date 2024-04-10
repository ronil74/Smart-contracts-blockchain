// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.12 <0.9.0;
import "./DataUsageSMContract.sol";
import "./Agreement.sol";
import "./Log.sol";

contract Verification {

address[] violatedActors;
uint [] vioList;
Log logs;
Agreement agreement;
DataUsageSMContract dataUsage;



//event LogMessage(bool consent, address actorId, address userId);
event LogMessage(address actorId, address userId, bool consent, string operation, string[] processedPersonalData);
event printActorViolator(address actorViolator);

 constructor(address _logsAddress, address _agreementAddress, address _dataUsage) {
   
       logs = Log(_logsAddress);
       agreement = Agreement(_agreementAddress);
       dataUsage = DataUsageSMContract(_dataUsage);
 
 }

function verify() public {

     Log.logInfo [] memory totalLogs = logs.getlogs();
     address actorId;
     for(uint i = 0; i < totalLogs.length; i++){
        actorId = totalLogs[i].actorId;
        address userId = msg.sender;
        bool consent = agreement.getAgreementByActorID(actorId, userId)[0].consent;
        string memory operation = agreement.getAgreementByActorID(actorId, userId)[0].operation;
        string[] memory processedPersonalData = agreement.getAgreementByActorID(actorId, userId)[0].processedPersonalData;
        
       
             if(keccak256(abi.encodePacked(totalLogs[i].operation)) == keccak256(abi.encodePacked(operation))){
                  if(totalLogs[i].personalData.length == processedPersonalData.length){
                        for (uint j = 0; j < totalLogs[i].personalData.length; j++) {
                        if (keccak256(abi.encodePacked(totalLogs[i].personalData[j])) == keccak256(abi.encodePacked(processedPersonalData[j]))) {
                               if(consent){
                                   emit LogMessage(actorId, userId, consent, operation, processedPersonalData);
                                   continue;
                               }
                               else{
                                    violatedActors.push(actorId);
                                    emit printActorViolator(actorId);
                               }
                                  

                  }
             }
        }

        
     }
            

      

     }

}
}
