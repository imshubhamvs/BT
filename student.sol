// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentsDataSafe {
    struct Student {
        uint rollNum;
        string name;
        uint marks;
    }

    Student[] private data;
    mapping(uint => uint) private rollNumToIndex;
    mapping(uint => bool) private exists;

    event StudentAdded(uint indexed roll, string name, uint marks);
    event Debug(string note, uint val);

    function add_student(uint _rollNum, string memory _name, uint _marks) public {
        require(!exists[_rollNum], "Student already exists");
        data.push(Student(_rollNum, _name, _marks));
        uint idx = data.length - 1;
        rollNumToIndex[_rollNum] = idx;
        exists[_rollNum] = true;
        emit StudentAdded(_rollNum, _name, _marks);
        emit Debug("added_count", data.length);
    }

    function get_student(uint _rollNum) public view returns (uint, string memory, uint) {
        require(exists[_rollNum], "Student not found");
        uint idx = rollNumToIndex[_rollNum];
        require(idx < data.length, "Index out of range");
        Student memory s = data[idx];
        return (s.rollNum, s.name, s.marks);
    }

    function get_count() public view returns (uint) {
        return data.length;
    }

    fallback() external payable { 
        emit Debug("Fallback was called",404); 
    } 
    receive() external payable { 
        emit Debug("Receive was called",404); 
    }
}
