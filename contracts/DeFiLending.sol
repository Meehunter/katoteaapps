// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DeFiLending {
        IERC20 public token;
            mapping(address => uint256) public balances;
                mapping(address => uint256) public borrows;

                    constructor(IERC20 _token) {
                                token = _token;
                    }

                        function supply() external payable {
                                    require(msg.value > 0, "Supply amount must be greater than 0");
                                            balances[msg.sender] += msg.value;
                        }

                            function borrow(uint256 amount) external {
                                        require(amount > 0, "Borrow amount must be greater than 0");
                                                require(balances[msg.sender] >= amount, "Insufficient balance to borrow");
                                                        require(token.balanceOf(address(this)) >= amount, "Insufficient token balance in contract");
                                                                balances[msg.sender] -= amount;
                                                                        borrows[msg.sender] += amount;
                                                                                require(token.transfer(msg.sender, amount), "Token transfer failed");
                            }

                                function repay() external payable {
                                            require(msg.value > 0, "Repay amount must be greater than 0");
                                                    require(borrows[msg.sender] >= msg.value, "Repay amount exceeds borrowed amount");
                                                            borrows[msg.sender] -= msg.value;
                                                                    payable(msg.sender).transfer(msg.value);
                                }

                                    function swap() external payable {
                                                require(msg.value > 0, "Swap amount must be greater than 0");
                                                        uint256 mteaAmount = msg.value * 100; // 1 TEA = 100 MTEA
                                                                require(token.balanceOf(address(this)) >= mteaAmount, "Insufficient MTEA in contract");
                                                                        require(token.transfer(msg.sender, mteaAmount), "MTEA transfer failed");
                                    }
}
                                    
                                
                            
                        
                    
