// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentRecords {

    struct Student {
        string name;
        uint age;
        string country;
        string major;
    }

    mapping(uint => Student) public students;

   
    function addStudent(uint _id, string memory _name, uint _age, string memory _country, string memory _major) public {
        students[_id] = Student(_name, _age, _country, _major);
    }

    
    function getStudent(uint _id) public view returns (string memory, uint) {
        Student memory s = students[_id];
        return (s.name, s.age);
    }
}
