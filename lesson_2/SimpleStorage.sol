//SPDX-License-Identifier: MIT
pragma solidity >0.8.1;

// this is a comment.

/* 
this is a 
multi-line comment
*/

// every contract starts with the declaration of license identifier
// and MUST have a pragma solidy defining which solidity versions are expected to compile the contract

// we define a new contract using the "contract" keywords, followed by the contract's name
contract SimpleStorage {
    // there are many different types in solidity, and they have to be declared (solidity is statically typed)
    // 1) Booleans: can only be true or false
    bool myBool = true;

    // 2) Integers: can have different sizes (int8 is 8 bytes long while int256 is 256 bytes long)
    int8 mySmallInt = -33;
    int256 myLongInt = 2e33; // e stands for the exponentiation

    // 3) Unsigned integers: like integers but can only assume positive values
    uint8 mySmallUint = 12;
    int256 myLongUint = 1 ether; // stands for 1e18

    // 4) Addresses: comes in two largely identical flavors
    address myAddress = 0x3746cFd972D3292Ed2567f8fD302E1e26b143535;
    address payable myPayableAddress; // can send money and receive money

    uint256 myBalance = myAddress.balance; // method returning the balance of an address
    address contractDeployer = msg.sender; // special address, refers to the one that deploys the current contract

    // 5) Structs: user defined types
    // suppose we want to define a Person type
    struct Person {
        uint256 age;
        address personalAddress;
    }

    // creating a new istance is
    Person pietro = Person(21, 0x3746cFd972D3292Ed2567f8fD302E1e26b143535);

    // 6) mappings: similar to python dictionaries
    // syntax mapping(KeyType KeyName? => ValueType ValueName?)
    mapping(uint256 uniqueId => address addresses) idToAddress;

    // setting and accessing a mapping
    // idToAddress[0] = 0x3746cFd972D3292Ed2567f8fD302E1e26b143535;
    address myAddressFromMapping = idToAddress[0];

    // 7) arrays: collection of similar data
    // syntax type[]
    uint256[] numbers;
    address[] addresses;

    // add and pop an element
    // numbers.push(22);
    // numbers.pop();

    // functions
    // public: accessible by anyone inside and outside the contract
    // internal: function can be called only by the contract itself
    // external: function can be called everyone but the contract itself
    // private: function can be called only by the contract itself and not the contracts that inherits his methods

    function pushToNumbers(uint256 newNum) public {
        numbers.push(newNum);
    }

    // getter vs setter
    function getMySmallInt() public view returns (int8) {
        // view if it doesn't perform any action but reading from the chain
        return mySmallInt;
    }

    function setMySmallInt(int8 newValue) public {
        mySmallInt = newValue;
    }

    // payable: used when we deal with money

    function sendEthToTheContract() public payable {
        // set a non-null value and call this function. It is usually used to set some logic
        // and trace who sent money
    }

    function sendEthToTheUser(uint256 amount) public payable {
        payable(msg.sender).transfer(amount);
    }
}
