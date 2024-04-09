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
![Blank diagram (2)](https://github.com/SmartReviewETH/Smart-Review/assets/152730008/b2e87586-b3a3-48ab-a974-f923debff63e)

## :fire:  Why choose Smart-Review
### Problem Statement
 - Traditional review is not incentivized and therefore lacks participation from a broader audience, especially in the open source and scientific community
 - Bias from reviewers may hinder the wide adoption of cutting-edge work
 - Traditional reviews usually take longer to process
### Our Solutions
- Key features
	- [ERC-20 token](https://ethereum.org/en/developers/docs/standards/tokens/erc-20/)
	  We implemented our own ERC-20 token named **SmartToken**, with symbol "**SMT**" [(view this token in Etherscan)](https://sepolia.etherscan.io/token/0xFb3901F9Fc06045f9cE03EeEB21485559A858784). The SMT tokens are rewarded to contributors in the community based on their roles and contributions as the following:
	  
		- A reviewer will be rewarded if the proposals of his/her review is approved and executed after the voting period by DAO
		- A member of the DAO will be rewarded if his/her voted proposal is approved and executed
	
	 	The reward mechanism with cryptocurrency will significantly improve the  incentivization of the community, encourage community members participating in activities. We also have a faucet mechanism for the tokens.

	- We implemented a smart contract to manage the SmartTokens and provide basic data types and operations (such as request for reviews on one's work, proposal for a review and completion of the request/proposal) to support our application.
	- A governor contract and voting DAO to support voting for reviews.
 	- A user-friendly frontend to visualize all operations.

- Please watch [this]() video on how to use this app.
- We have the potential users as following:
	- A researcher new to the research community and has some potential cutting-edge discoveries/inventions. He/she can submit his/her work on our platform.
	- A researcher who wishes to get inspired from others' works with incentives and hope someone to check his/her thoughts. He/she can leave a review on our platform.
 	- A researcher who has thoughts on others' reviews about someone's work and expect to see his thoughts are proved true/false in some way. He/she can vote for the reviews.
	- Practitioners with other occupations with the similiar goals.

## :heavy_exclamation_mark: Acknowledgement

To build our project, we have been inspired from some previous works.
 - [AntsReview](https://github.com/naszam/ants-review)
 	- allow issuers to issue an AntReview
  	- a bounty for peer-review in scientific publication
   	- linked to requirements stored on ipfs which peer-reviewers can fufill by submitting the ipfs hash which contains evidence of their fufillment
	- after the submission of successful peer-reviews, they will be approved by an approver and payed in ANTS
   We designed our workflow based on the framework of this project. But we have added our own components, such as review request proposal, review completion, voting mechanism, etc.

