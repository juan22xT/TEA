// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;


contract AVCO {
  struct Inventory{
      int value;
      int count;
  }
  
  Inventory inventory;
    // initialize inventory profit records with an empty array
  int[] profits;
    // creates an array of integers named "profits"
  
    function getInventory() public view returns(int, int) {
        return (inventory.value, inventory.count);
    }
    // creates a function named "getInventory" which returns two integers
    // the first integer is the field stored of the "value" of the "inventory" object of type Inventory
    // the second integer is the field stored of the "count" of the "inventory" object of type Inventory
    /// the "public" command allows the user to interact with this function from outside of the smart contract
    /// (to decide whether and when to run it)
    /// the function is already a read-only function, as it does not change the state of the contract
    /// however, the "view" command further specifies this read-only attribute, which is convenient
    
    function getProfits() public view returns(int[] memory) {
        return profits;
    }
    /// creates a public read-only function named "getProfits" which returns an array of integers named "profits"
    /// the "profits" array is empty for the moment, we will fill it in further below
    /// the "memory" command retrieves the array from local memory storage
    
    function addOneUnit(int inventoryValueAdded) public {
        inventory.value += inventoryValueAdded;
        inventory.count += 1;
    }
    /// creates a public function named "addOneUnit" in which the user inputs an integer named "inventoryValueAdded"
    /// the function re-declares the "value" of the "inventory" object as its prior value plus "inventoryValueAdded"
    /// the function also re-declares the "count" of the "inventory" object as its prior value plus one

    function sellInventory(int salePrice) public {
    /// creates a public function named "sellInventory" in which the user inputs an integer named "salePrice"
    
        int cogs = inventory.value/inventory.count;
        // the function defines "cogs" (cost of goods sold) as a variable of type "integer"
        // and defines cogs as the quotient between the "value" and the "count" of the inventory object (i.e. the average cost of the inventory)
        
        int profit = salePrice - cogs;
        // the function defines "profit" as a variable of type "integer"
        // and defines "profit" as the difference between the "salePrice" and "cogs" (both defined above)
        
        inventory.count -= 1;
        // the function re-declares the "count" of the "inventory" object as its prior value minus one
        
        inventory.value -= cogs;
        // the function also re-declares the "value" of the "inventory" object as its prior value minus "cogs"
        
        profits.push(profit);
        // the function adds the value of the "profit" variable defined above as a new element into the "profits" array
    }
}
