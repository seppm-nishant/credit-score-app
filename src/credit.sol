// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract LendingReputation {
    struct Request {
         uint256 amount;
         address borrower;
         bool fulfilled; 
    }

    uint256 requestIdCounter; 
    mapping(uint256 => Request) public requests;

    event RequestCreated(uint256 requestId, uint256 amount, address borrower);
    event RequestAccepted(uint256 requestId);
    event Borrowed(uint256 requestId);
    event Repaid(uint256 requestId);

    // Update reputation score elsewhere based on events

    function borrow_request(uint256 _amount) external {
        requestIdCounter++;
        requests[requestIdCounter] = Request(_amount, msg.sender, false);
        emit RequestCreated(requestIdCounter, _amount, msg.sender);
    }

    function accept_request(uint256 _requestId) external {
        require(requests[_requestId].fulfilled == false); 
        requests[_requestId].fulfilled = true;
        emit RequestAccepted(_requestId); 
    }

    function borrow(uint256 _requestId) external {
    require(requests[_requestId].fulfilled == true); 
    // ... Logic to transfer funds to the borrower (consider safety and interaction with a token contract if using your own tokens, or native currency transfer)
    emit Borrowed(_requestId); 
    }

    function repay(uint256 _requestId) external payable {
    // ... Logic to receive repayment & check the amount with interest calculation
    // ... If applicable, transfer funds back to the lender 
    emit Repaid(_requestId); 

    }

    // function burnFrom(address account, uint256 _requestId) external override {
    //     if (account != msg.borrower) {
    //         _spendAllowance(account, msg.borrower, _requestId);
    //     }
    //     _burn(account, _requestId);
    // }

    // function _burn(address account, uint256 _requestId) internal override {
    //     super._burn(account, _requestId);
    // }
}
