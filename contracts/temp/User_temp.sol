// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// contract Users {

//     address _owner;

//     constructor() {
//         _owner = msg.sender;
//     }

//     uint id;

//     struct User {
//         address id;
//         // string name;
//         // string email;
//         // uint role;
//         bool isCreated;
//         uint256 createdAt;
//         uint updatedAt;
//     }
    
//     mapping(address => User) users;
//     address[] public allUsers;

//     //tạo người dùng
//     function createUser(
//         // string memory _name,
//         // string memory _email,
//         // uint _role,
//         address userAddress
//     ) external {
//         require(!users[userAddress].isCreated, "You are Already Registered!");

//         User memory user = User(
//             userAddress,
//             // _name,
//             // _email,
//             // _role,
//             true,
//             block.timestamp,
//             block.timestamp
//         );

//         users[userAddress] = user;
//         allUsers.push(userAddress);
//     }
    
//     // function changeInfo(address _userId, string memory name, string memory email, uint role) external {
//     //     require(users[_userId].isCreated, "User has not been initialized");
//     //     require(users[_userId].id == _userId, "You have no right");
//     //     users[_userId].name = name;
//     //     users[_userId].email = email;
//     //     users[_userId].role = role;
//     // }   

//     // lấy dữ liệu người dùng theo địa chỉ
//     function getUserByAddress(address _userId) external view returns (User memory){
//         User memory res = users[_userId];
//         return res;
//     }

//     // lấy tất cả dữ liệu người dùng
//     function getAllUser() external view returns (User[] memory) {
//         User[] memory res = new User[](allUsers.length);
//         for (uint256 i = 0; i < allUsers.length; i++) {
//             res[i] = users[allUsers[i]];
//         }
//         return res;
//     }
// }
