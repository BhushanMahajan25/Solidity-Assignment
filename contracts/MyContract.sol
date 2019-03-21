pragma solidity ^0.5.1;

contract Owned{
    address owner;
    
    constructor()public{
        owner = msg.sender;
    }
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
}

contract MyContract is Owned{
    
    struct Banker{
        uint bankerID;
        uint bankerPhoneNo;
        string bankerName;
        string branchName;
    }
        
    struct Customer{
        uint custID;
        uint custPhoneNo;
        string custName;
        string custAddress;
        uint custAccNo;
    }
    
    uint private bid;
    uint private cid;
    //mapping(address => Banker) bankerMap;
    mapping(uint => Customer) custMap;
    mapping(uint => Banker) bankerMap;
    //mapping(address => Customer) custMap;
    
    uint [] private bankerAcc;
    uint [] private custAcc;
    uint [] private sharedCust;
    
   // event bankerEvent(string bankerName,uint bankerID,uint bankerPhoneNo,string branchName);
    
    function setBankerData(string memory _bankerName,uint _bankerID,uint _bankerPhoneNo,string memory _branchName) onlyOwner public{
        Banker storage bank = bankerMap[_bankerID];
        bank.bankerName = _bankerName;
        bank.bankerID = _bankerID;
        bid = _bankerID;
        bank.bankerPhoneNo = _bankerPhoneNo;
        bank.branchName = _branchName;
        
        bankerAcc.push(_bankerID) -1;
        
       // emit bankerEvent(_bankerName,_bankerID,_bankerPhoneNo,_branchName);
    }
    
    function getBankerAcc() view public returns(uint[] memory){
        return bankerAcc;
    }
    
    function getBankerData()view public returns(string memory,uint,uint,string memory){
        return (bankerMap[bid].bankerName,bankerMap[bid].bankerID,bankerMap[bid].bankerPhoneNo,bankerMap[bid].branchName);
    }
    
    function countBankers() view public returns(uint){
        return bankerAcc.length;
    }
    
    //event custEvent(string custName,uint custID,uint custPhoneNo,string custAddress,uint custAccNo);
    
    function setCustData(string memory _custName,uint _custID,uint _custPhoneNo,string memory _custAddress,uint _custAccNo) onlyOwner public{
       // Customer storage c = custMap[_address];
        Customer storage c = custMap[_custID];
        c.custName=_custName;
        c.custID=_custID;
        cid=_custID;
        c.custPhoneNo=_custPhoneNo;
        c.custAddress=_custAddress;
        c.custAccNo=_custAccNo;
        
        custAcc.push(_custID) -1;
        
        //emit custEvent(_custName,_custID,_custPhoneNo,_custAddress,_custAccNo);
    }
    
    function getCustAcc() view public returns(uint[] memory){
        return custAcc;
    }
    
      function countCustomers() view public returns(uint){
        return custAcc.length;
    }
    
    function getCustData()view public returns(string memory,uint,uint,string memory,uint){
        return (custMap[cid].custName,custMap[cid].custID,custMap[cid].custPhoneNo,custMap[cid].custAddress,custMap[cid].custAccNo);
    }
    
    function getSharedCustData(uint i)view public returns(string memory,uint,uint,string memory,uint){
        uint id = sharedCust[i];
        return (custMap[id].custName,custMap[id].custID,custMap[id].custPhoneNo,custMap[id].custAddress,custMap[id].custAccNo);
    }
    
    function shareInfo(uint id) public{
        sharedCust.push(id) -1;
    }
    
    function getSharedCustLen() view public returns(uint){
        return sharedCust.length;
    }
    
    
}