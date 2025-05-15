// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { InterchainTokenExecutable } from '@axelar-network/interchain-token-service/contracts/executable/InterchainTokenExpressExecutable.sol';


enum Command {
       ENCREASE,
       DECREASE
}

contract InterchainCounter is InterchainTokenExecutable {
    uint public counter;

    function getCounter() external view returns (uint) {
        return counter;
    }

    constructor(address interchainTokenService_) InterchainTokenExecutable(interchainTokenService_) {}

    function _executeWithInterchainToken(
        bytes32 commandId,
        string calldata sourceChain,
        bytes calldata sourceAddress,
        bytes calldata data,
        bytes32 tokenId,
        address token,
        uint256 amount
    ) internal override {
        (uint8 commend) = abi.decode(data, (uint8));
        if(commend == uint8(Command.ENCREASE)) {
            encrease();
        }
        if(commend == uint8(Command.DECREASE)) {
            decrease();
        }
    }

    function encrease() public {
        counter+=1;
    }

    function decrease() public{
        counter-=1;
    }
}