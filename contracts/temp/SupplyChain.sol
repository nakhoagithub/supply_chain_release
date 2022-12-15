// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "./Users.sol";
// import "./Products.sol";

// contract SupplyChain {
//     Users user;
//     Products product;

//     constructor() {
//         user = new Users();
//         product = new Products();
//     }

//     function createUser(
//         // string memory _name,
//         // string memory _email,
//         // uint256 _role
//     ) public {
//         user.createUser(msg.sender);
//     }

//     // function changeInfo(
//     //     string memory name,
//     //     string memory email,
//     //     uint256 role
//     // ) external {
//     //     user.changeInfo(msg.sender, name, email, role);
//     // }

//     function getUserByAddress(address _userId)
//         public
//         view
//         returns (Users.User memory)
//     {
//         return user.getUserByAddress(_userId);
//     }

//     function getAllUser() public view returns (Users.User[] memory) {
//         return user.getAllUser();
//     }

//     // function transfer(
//     //     string memory productId,
//     //     string memory newProductId
//     // ) public {
//     //     product.buyProduct(productId, newProductId, msg.sender);
//     // }

//     // function getSingleProductById(string memory idProduct) public view returns (Products.Product memory){
//     //     return product.getSingleProductById(idProduct);
//     // }

//     // function getAllProduct() public view returns (Products.Product[] memory){
//     //     return product.getAllProduct();
//     // }

//     // function getUserProducts() public view returns (Products.Product[] memory){
//     //     return product.getUserProduct(msg.sender);
//     // }

//     // function getProductHistory(string memory idProduct) public view returns (Products.ProductHistory[] memory) {
//     //     return product.getProductHistory(idProduct);
//     // }
// }
