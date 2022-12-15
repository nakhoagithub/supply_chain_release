// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Users {

    address _owner;

    constructor() {
        _owner = msg.sender;
    }

    uint id;

    struct User {
        address id;
        // string name;
        // string email;
        // uint role;
        bool isCreated;
        uint256 createdAt;
        uint updatedAt;
    }
    
    mapping(address => User) public users;
    address[] public allUsers;

    //tạo người dùng
    function createUser(
        address userAddress
    ) external {
        require(!users[userAddress].isCreated, "You are Already Registered!");

        User memory user = User(
            userAddress,
            true,
            block.timestamp,
            block.timestamp
        );

        users[userAddress] = user;
        allUsers.push(userAddress);
    }

    // lấy dữ liệu người dùng theo địa chỉ
    function getUserByAddress(address _userId) external view returns (User memory){
        User memory res = users[_userId];
        return res;
    }

    // lấy tất cả dữ liệu người dùng
    function getAllUser() external view returns (User[] memory) {
        User[] memory res = new User[](allUsers.length);
        for (uint256 i = 0; i < allUsers.length; i++) {
            res[i] = users[allUsers[i]];
        }
        return res;
    }
}
