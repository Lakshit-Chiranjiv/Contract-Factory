// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract SimpleCounter {

    // Stores the current count value on-chain.
    // Every read of this variable pulls the latest value from the blockchain state.
    uint256 private count;

    // Stores the address that deployed this contract.
    // Set once in the constructor and never changed.
    address public owner;

    // Emitted whenever the count changes, along with who changed it and the new value.
    // Frontends/scripts can listen for this to update UI without polling the contract.
    event CountChanged(address indexed changedBy, uint256 newCount);

    // Runs exactly once, at deployment time.
    // Sets the deployer as the owner and initializes count to 0.
    constructor() {
        owner = msg.sender;
        count = 0;
    }

    // Restricts a function to only be callable by the owner.
    // If the check fails, the function call reverts and no state changes are saved.
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized: caller is not the owner");
        _;
    }

    // Increases count by 1.
    // Anyone can call this — no restriction.
    function increment() external {
        count += 1;
        emit CountChanged(msg.sender, count);
    }

    // Decreases count by 1.
    // Reverts if count is already 0, since uint256 cannot go negative.
    function decrement() external {
        require(count > 0, "Count is already 0");
        count -= 1;
        emit CountChanged(msg.sender, count);
    }

    // Resets count back to 0.
    // Restricted to the owner only, using the onlyOwner modifier defined above.
    function reset() external onlyOwner {
        count = 0;
        emit CountChanged(msg.sender, count);
    }

    // Returns the current count.
    // Marked "view" since it only reads state and doesn't cost gas when called externally.
    function getCount() external view returns (uint256) {
        return count;
    }
}