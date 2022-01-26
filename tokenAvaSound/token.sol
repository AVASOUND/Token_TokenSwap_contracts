// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;


interface IERC20 {
    function TotalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (bool);
    function approve(address spender, uint amount) external returns (uint);
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);
}

contract ERC20 is IERC20 {

    uint public TotalSupply; 
    // this variable will increase when minting and vice versa when burning

    mapping(address => uint) public balanceOf;
    //  how many ERC20 token does the account holds

    mapping(address => mapping(address => uint)) public allowance;
    // owner of ERC20 approves spender to send certain amount of ERC20

    string public name = "AvaSound";
    string public symbol = "AVAS";
    uint8 public decimals = 18;
    // standard for token metadata

    function transfer(address recipient, uint amount) external returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint amount) external returns (bool) {
        
        allowance[address msg.sender, address spender, uint amount];
// I'm having issues with the allowance
//it is not compiling. I'm still trying to figure it out here

        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint amount) external returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        TotalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        TotalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}