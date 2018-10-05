pragma solidity ^0.4.18;

import "./ConvertLib.sol";

// 这是一个简单的仿币合约的例子。它并不是标准的可兼容其他币或token的合约，
// 如果你想创建一个标准兼容的token，请转到 https://github.com/ConsenSys/Tokens（TODO:一会儿我们再过去转）

contract MetaCoin {
    mapping (address => uint) balances;// 定义了一个映射类型变量balances，key为address类型，值为无符整型，应该是用来存储每个账户的余额，可以存多个。

    event Transfer(address indexed _from, address indexed _to, uint256 _value);// Solidity语法event，TODO:见下方详解。

    function MetaCoin() public {// 构造函数，tx.origin查查上面，找到它会返回交易发送方的地址，也就是说合约实例创建时会默认为当前交易发送方的余额塞10000，单位应该是你的仿币。
        balances[tx.origin] = 10000;
    }

    function sendCoin(address receiver, uint amount) public returns(bool sufficient) {// 函数声明部分没有盲点，方法名，参数列表，函数可见性，返回值类型定义。
        if (balances[msg.sender] < amount) return false;// 如果余额不足，则返回发送币失败
        balances[msg.sender] -= amount;// 否则从发送方余额中减去发送值，注意Solidity也有 “-=”，“+=” 的运算符哦
        balances[receiver] += amount;// 然后在接收方的余额中加入发送值数量。
        Transfer(msg.sender, receiver, amount);// 使用以上event关键字声明的方法
        return true;
    }

    function getBalanceInEth(address addr) public view returns(uint){// 获取以太币余额
        return ConvertLib.convert(getBalance(addr),2);// 调用了其他合约的方法，TODO:稍后介绍ConvertLib合约时说明。
    }

    function getBalance(address addr) public view returns(uint) {// 获取当前账户的仿币余额
        return balances[addr];
    }
}