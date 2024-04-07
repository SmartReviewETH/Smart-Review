# Smart-Review(Decentralized Review Platform)
|[:rocket:Quick Start](#start_id) | [:fire:Why choose Smart Review](#wse-id)|
## :star: Context
- Smart-Review is a decentralized review platform with an incentivized and private reviewing mechanism
- This repository involves the smart contracts written in solidity



## :rocket: Quick Start
Please run the [Web App](https://smartreview1.netlify.app) to start
Before running it, please ensure :

 - Meta Mask installed (Mobile APP or browser plugin)
 - Sepolia ETH available (gas fee for voting)
 - Ethereum network changed to Sepolia test network

:fire:Here are some resources where you can get free Sepolia ETH:
	

 - [Alchemy Sepolia Faucet](https://www.alchemy.com/faucets/ethereum-sepolia)
 - [Infura Sepolia Faucet](https://www.infura.io/faucet/sepolia)

## :eyes: Front end Github repo
https://github.com/SmartReviewETH/smart-review-front-end

## System Architecture
![Blank diagram (2)](https://github.com/vvvxxx321/Smart-Review/assets/55036290/66cc9ae2-7bf5-447f-a831-6111354e8229)

## :fire:  Why choose Smart-Review
### Problem Statement
 - Traditional review is not incentivized and therefore lacks participation from a broader audience, especially in the open source and scientific community
 - Bias from reviewers may hinder the wide adoption of cutting-edge work
 - Traditional reviews usually take longer to process
### Our Solutions
 - [ERC-20 token](https://ethereum.org/en/developers/docs/standards/tokens/erc-20/)
	  We implemented our own ERC-20 token named **SmartToken**, with symbol "**SMT**" [(view this token in Etherscan)](https://sepolia.etherscan.io/token/0xFb3901F9Fc06045f9cE03EeEB21485559A858784). The SMT tokens are rewarded to contributors in the community based on their roles and contributions as the following:
	  
	 - A reviewer will be rewarded if the proposals of his/her review is approved and executed after the voting period by DAO
	 - A member of the DAO will be rewarded if his/her voted proposal is approved and executed
	 - ...
	
	 The reward mechanism with cryptocurrency will significantly improve the  incentivization of the community, encourage community members participating in activities.
