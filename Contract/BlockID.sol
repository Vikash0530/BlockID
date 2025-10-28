// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title BlockID
 * @dev A decentralized digital identity management system.
 * Users can register, update, and verify their unique blockchain identity.
 */
contract BlockID {
    // --- Data Structures ---
    struct Identity {
        string name;
        string email;
        uint256 createdAt;
        bool isRegistered;
    }

    mapping(address => Identity) private identities;

    // --- Events ---
    event IdentityRegistered(address indexed user, string name, string email);
    event IdentityUpdated(address indexed user, string newName, string newEmail);

    // --- Core Functions ---

    /**
     * @notice Register a new digital identity.
     * @param _name The name of the user.
     * @param _email The email of the user.
     */
    function registerIdentity(string calldata _name, string calldata _email) external {
        require(!identities[msg.sender].isRegistered, "Already registered");
        identities[msg.sender] = Identity(_name, _email, block.timestamp, true);
        emit IdentityRegistered(msg.sender, _name, _email);
    }

    /**
     * @notice Update an existing digital identity.
     * @param _newName The updated name.
     * @param _newEmail The updated email.
     */
    function updateIdentity(string calldata _newName, string calldata _newEmail) external {
        require(identities[msg.sender].isRegistered, "Identity not found");
        identities[msg.sender].name = _newName;
        identities[msg.sender].email = _newEmail;
        emit IdentityUpdated(msg.sender, _newName, _newEmail);
    }

    /**
     * @notice Fetch identity details for a specific address.
     * @param _user The wallet address of the user.
     * @return name, email, createdAt, isRegistered
     */
    function getIdentity(address _user)
        external
        view
        returns (string memory, string memory, uint256, bool)
    {
        Identity memory id = identities[_user];
        return (id.name, id.email, id.createdAt, id.isRegistered);
    }
}
