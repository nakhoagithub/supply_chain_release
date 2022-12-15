// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Products {
    struct ProductTransfer {
        string idTransfer;
        string idHistory;
        string idProduct;
        address owner;
        address buyer;
        string name;
        string dictIngredient;
        string description;
        bool isCreated;
        uint256 transferDate;
    }

    mapping(address => ProductTransfer[]) internal allTransferOfUser;
    mapping(string => ProductTransfer[]) internal transfersHistory;
    mapping(string => ProductTransfer) internal transfers;
    string[] internal allTransfer;

    function transferProduct(
        string memory idTransfer,
        string memory idHistory,
        string memory idProduct,
        address owner,
        address buyer,
        string memory name,
        string memory dictIngredient,
        string memory description
    ) external {
        require(
            !transfers[idTransfer].isCreated,
            "Transaction ID already exists!"
        );

        ProductTransfer memory productTransfer = ProductTransfer(
            idTransfer,
            idHistory,
            idProduct,
            owner,
            buyer,
            name,
            dictIngredient,
            description,
            true,
            block.timestamp
        );

        // tất cả các giao dịch của một người
        allTransferOfUser[owner].push(productTransfer);

        // trong một chuỗi có cùng idHistory
        transfersHistory[idHistory].push(productTransfer);

        // tất cả các giao dịch
        transfers[idTransfer] = productTransfer;
        allTransfer.push(idTransfer);
    }

    function getAllTransferOfUser(address owner)
        external
        view
        returns (ProductTransfer[] memory)
    {
        return allTransferOfUser[owner];
    }

    function getTransferHistory(string memory idHistory)
        external
        view
        returns (ProductTransfer[] memory)
    {
        return transfersHistory[idHistory];
    }

    function getAllTransfer() external view returns (ProductTransfer[] memory) {
        ProductTransfer[] memory res = new ProductTransfer[](
            allTransfer.length
        );
        for (uint256 i = 0; i < allTransfer.length; i++) {
            res[i] = transfers[allTransfer[i]];
        }
        return res;
    }
}
