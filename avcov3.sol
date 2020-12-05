pragma solidity ^0.7.0;


contract AVCOv3 {
  // initialize inventory balance with an empty array
    struct Inventory{
      int value;
      int count;
  }
  Inventory inventory;
    // initialize inventory profit records with an empty array

  // 1 unit = 10^-18 Ether = 1 wei
  int[] profits;
  // creates an array of integers named "profits"
  address payable inventoryHolder = 0x56f4C647e27f901919227939052f6b4480A7557A;
  // defines the address of Alice (0x56...) as "inventoryHolder"
  // declares "inventoryHolder" as the address where Ether will be paid by the user interacting with this smart contract (Bob)
  
  mapping (address => int) inventoryBalance;
  // converts the content (balance) of a given address in an integer named "inventoryBalance"

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
    
    function getInventoryBalance(address someAddress) public view returns(int) {
        return inventoryBalance[someAddress];
    }
    // creates a variable named "someAddress" of the "address" type. The user inputs the address
    // creates a public read-only function named "getInventoryBalance" which returns the balance of "someAddress" as an integer
    
    function addOneUnit(int inventoryAdded) public {
        inventory.value += inventoryAdded;
        inventory.count += 1;
    }
    /// creates a public function named "addOneUnit" in which the user inputs an integer named "inventoryAdded"
    /// the function re-declares the "value" of the "inventory" object as its prior value plus "inventoryAdded"
    /// the function also re-declares the "count" of the "inventory" object as its prior value plus one

    function buyOneUnit() public payable {
        inventoryHolder.transfer(msg.value);
        
        // function buyOneUnit(uint value) public payable {
        // inventoryHolder.transfer(value);
        
        // creates a public function named "buyOneUnit". It is "payable," meaning that the user can interact with funds/wallets
        // Alice ("inventoryHolder") is transferred an amount determined by the user interacting with the smart contract (Bob): "msg.value" is the amount
        
        int cogs = inventory.value/inventory.count;
        // the function defines "cogs" (cost of goods sold) as a variable of type "integer"
        // and defines cogs as the quotient between the "value" and the "count" of the inventory object (i.e. the average cost of the inventory)
        
        inventoryBalance[inventoryHolder] -= 1;
        // Alice's inventory is redefined as its previous value minus one
        
        inventoryBalance[msg.sender] += 1;
        // Bob's inventory is redefined as its previous value plus one
        
        int profit = int(msg.value) - cogs;
        // the function defines "profit" as a variable of type "integer"
        // and defines "profit" as the difference between the sale price ("msg.value" converted to integer) and "cogs" (both defined above)
        
        inventory.count -= 1;
        inventory.value -= cogs;
        // the function re-declares the "count" of the "inventory" object as its prior value minus one
        // the function also re-declares the "value" of the "inventory" object as its prior value minus "cogs"
        
        profits.push(profit);
        // the function adds the value of the "profit" variable defined above as a new element into the "profits" array
    }
}
