// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;



contract Parent {
    function sayHello() public pure returns (string memory) {
        return "Hello from Parent";
    }
}

contract Child is Parent {
    function sayHelloFromChild() public pure returns (string memory) {
        return "Hello from Child";
    }
}


contract Parent_f {
    function externalFunction() public pure returns (string memory) {
        return "Called from another contract";
    }
}

contract Child_f {
    Parent_f externalContract;

    constructor(address _externalContractAddress) {
        externalContract = Parent_f(_externalContractAddress);
    }

    function callExternalFunction() public view returns (string memory) {
        return externalContract.externalFunction();
    }
}


contract School {
    string public schoolName;

    constructor(string memory _name) {
        schoolName = _name;
    }

    function getSchoolName() public view returns (string memory) {
        return schoolName;
    }
}

contract StudentsSystem is School {

    struct Student {
        string name;
        uint mathGrade;
        uint scienceGrade;
    }

    mapping(uint => Student) public students;

    constructor(string memory _schoolName) School(_schoolName) {
        
    }

    function addStudent(uint _id, string calldata _name, uint _mathGrade, uint _scienceGrade) public {
        students[_id] = Student(_name, _mathGrade, _scienceGrade);
    }

    function getStudent(uint _id) public view returns (string memory, uint, uint) {
        Student memory s = students[_id];
        return (s.name, s.mathGrade, s.scienceGrade);
    }
}


contract AdminControl {
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }

    function changeAdmin(address _newAdmin) public onlyAdmin {
        admin = _newAdmin;
    }
}


contract FullSchoolSystem is StudentsSystem, AdminControl {

    constructor(string memory _schoolName) 
        StudentsSystem(_schoolName) 
        AdminControl() {    
    }

    function getFullDetails(uint _id) public view returns (string memory, 
        uint, uint, string memory, address) {
        (string memory name, uint mathGrade, uint scienceGrade) = getStudent(_id);
        return (name, mathGrade, scienceGrade, getSchoolName(), admin);
    }
}
