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

## :computer: System Architecture
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

## :mortar_board: How to use?
__Note:__ please watch the [instruction video]() section at first.

- __How to set up the application?__ We have provided an [online application](https://smartreview1.netlify.app) for you, so you do not have to setup locally.
- __Any required library?__ No, this application has been deployed on cloud.
- __How to run it?__ Please follow the [demo video](), which walks through all the operations you can take.
- __How this application helps different types of users?__ We are proud to say that our application can adapt the general usage for all kinds of users who would like share their innovative ideas and leave reviews on these ideas which can then be voted to guarantee the quality. All the operations are incentivized.
- __About wallet?__ Please connect to your Metamask account to support any transaction on this platform. We used __sepolia__ as our testnet. Please get at least 0.01 SepoliaETH before connecting any operation since you need this to start any transaction.

## :pager: Local setup instructions

Actually you do not have to setup this application locally, since you can access this application online. But we can provide ideas on local setup.

- __Dependencies:__ You must install dependencies for our front end. Please clone our front end repository at first, then switch to the root directory and run __npm install__ to install all required libraries, and run __npm start__ to start the front end. We have deployed all smart contracts for you.
- __Tests__: We use the front end for usability tests, so we do not have a script for performance tests.
- __Smart contracts deployment__: You do not have to deploy any, but here is an instruction on deployment. This repository holds all smart contracts for this application, you can first clone this repository to the [Remix](https://remix.ethereum.org/), a browser-embedded IDE for smart contracts implemented with Solidity. Then compile and deploy each smart contract by the following steps:
	- ...
	- Compile the SmartToken contract, and then deploy it.
 	- Compile the SmartReviewContract contract, and provide the address of SmartToken contract to SmartReviewContract contract to deploy it.

## :heavy_exclamation_mark: Acknowledgement

To build our project, we have been inspired from some previous works.
 - [AntsReview](https://github.com/naszam/ants-review)
 	- allow issuers to issue an AntReview
  	- a bounty for peer-review in scientific publication
   	- linked to requirements stored on ipfs which peer-reviewers can fufill by submitting the ipfs hash which contains evidence of their fufillment
	- after the submission of successful peer-reviews, they will be approved by an approver and payed in ANTS
   We designed our workflow based on the framework of this project. But we have added our own components, such as review request proposal, review completion, voting mechanism, etc.

