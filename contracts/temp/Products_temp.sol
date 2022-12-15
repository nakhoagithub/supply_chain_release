// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Products {
    // struct Product {
    //     string Id;
    //     string productName;
    //     uint256 price;
    //     string currency;
    //     string description;
    //     address owner;
    //     uint256 count;
    //     string countingUnit;
    //     bool isCreated;
    //     uint256 createdAt;
    // }

    struct ProductHistory {
        address prevOwner;
        string Id;
        string productName;
        uint256 price;
        string currency;
        string description;
        string actionName;
        uint256 transferDate;
    }

    // mapping(string => Product) internal products;
    mapping(address => string[]) internal ownerProducts;
    mapping(string => ProductHistory[]) internal productHistories;
    string[] internal allProducts;

    // function createProduct(
    //     string memory idProduct,
    //     string memory productName,
    //     uint256 price,
    //     string memory currency,
    //     string memory description,
    //     uint256 _count,
    //     string memory _countingUnit,
    //     address productOwner
    // ) external {
    //     require(!products[idProduct].isCreated, "Item already created!");
    //     // require(users[msg.sender].isCreated, "You are not Registered as Seller"); //check user role

    //     Product memory product = Product(
    //         idProduct,
    //         productName,
    //         price,
    //         currency,
    //         description,
    //         productOwner,
    //         _count,
    //         _countingUnit,
    //         true,
    //         block.timestamp
    //     );

    //     products[idProduct] = product;
    //     ownerProducts[productOwner].push(idProduct);

    //     addProductHistory(idProduct, productOwner, price, description, "Created");
    //     allProducts.push(idProduct);
    // }

    // function addProductHistory(
    //     string memory idProduct,
    //     address owner,
    //     uint256 price,
    //     string memory description,
    //     string memory actionName
    // ) public {
    //     ProductHistory memory _history = ProductHistory(
    //         owner,
    //         idProduct,
    //         products[idProduct].productName,
    //         price,
    //         products[idProduct].currency,
    //         description,
    //         actionName,
    //         block.timestamp
    //     );
    //     productHistories[idProduct].push(_history);
    // }

    // function getAllProduct() external view returns (Product[] memory) {
    //     Product[] memory res = new Product[](allProducts.length);
    //     for (uint256 i = 0; i < allProducts.length; i++) {
    //         res[i] = products[allProducts[i]];
    //     }
    //     return res;
    // }

    function getProductHistory(string memory idProduct)
        external
        view
        returns (ProductHistory[] memory)
    {
        return productHistories[idProduct];
    }

    // function setOwner(string memory idProduct, address newOwner) external {
    //     products[idProduct].owner = newOwner;
    // }

    // function buyProduct(
    //     string memory productId,
    //     string memory newProductId,
    //     address buyerAddress
    // ) external {
    //     require(!products[newProductId].isCreated, "Id product is exists!");
    //     require(
    //         products[productId].owner != buyerAddress,
    //         "Can't buy my own products!"
    //     );

    //     Product memory oldProduct = products[productId];
    //     Product memory product = Product(
    //         newProductId,
    //         oldProduct.productName,
    //         oldProduct.price,
    //         oldProduct.currency,
    //         oldProduct.description,
    //         buyerAddress,
    //         oldProduct.count,
    //         oldProduct.countingUnit,
    //         true,
    //         block.timestamp
    //     );

    //     products[newProductId] = product;
    //     allProducts.push(newProductId);
    //     addProductHistory(
    //         productId,
    //         buyerAddress,
    //         products[newProductId].price,
    //         products[newProductId].description,
    //         "Bought"
    //     );
    //     ownerProducts[buyerAddress].push(newProductId);
    // }

    // function getSingleProductById(string memory idProduct)
    //     external
    //     view
    //     returns (Product memory)
    // {
    //     Product memory res = products[idProduct];
    //     return res;
    // }

    // function getUserProduct(address productOwner)
    //     external
    //     view
    //     returns (Product[] memory)
    // {
    //     string[] memory ownerProduct = ownerProducts[productOwner];
    //     Product[] memory res = new Product[](ownerProduct.length);
    //     for (uint256 i = 0; i < ownerProduct.length; i++) {
    //         string memory productId = ownerProduct[i];
    //         string memory name = products[ownerProduct[i]].productName;
    //         uint256 price = products[ownerProduct[i]].price;
    //         string memory currency = products[ownerProduct[i]].currency;
    //         string memory description = products[ownerProduct[i]].description;
    //         uint256 count = products[ownerProduct[i]].count;
    //         string memory countingUnit = products[ownerProduct[i]].countingUnit;
    //         address owner = products[ownerProduct[i]].owner;
    //         uint createdAt = products[ownerProduct[i]].createdAt;

    //         res[i] = Product(
    //             productId,
    //             name,
    //             price,
    //             currency,
    //             description,
    //             owner,
    //             count,
    //             countingUnit,
    //             true,
    //             createdAt
    //         );
    //     }
    //     return res;
    // }
}