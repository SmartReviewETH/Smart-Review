
# Smart-Review(Decentralized Review Platform)
| [:rocket: Quick Start](#rocket-quick-start) | [:mortar_board: How to use](#mortar_board-how-to-use) | [:fire: Why choose Smart-Review](#fire--why-choose-smart-review) | \
| [:pager: Local setup instructions](#pager-local-setup-instructions) | [:heavy_exclamation_mark: Acknowledgement](#heavy_exclamation_mark-acknowledgement) |

## :page_with_curl: License
MIT license

## :star: Context
- Smart-Review is a decentralized review platform with an incentivized and private reviewing mechanism.
- Our project consists of two GitHub repositories. This repository involves the smart contracts written in solidity, which constitutes the backend of our application. Please access the frontend repository in the [**Front end Github repo**](https://github.com/SmartReviewETH/Smart-Review?tab=readme-ov-file#eyes-front-end-github-repo) section. The primary description of our project can be found in this Readme documentation.

## :rocket: Quick Start
Link to our [Web App](https://smartreview1.netlify.app) . \
:pushpin: Before running it, we strongly suggest you to read the section [:mortar_board: How to use](#mortar_board-how-to-use) \
:heavy_exclamation_mark: And please ensure:

 - Meta Mask installed (Mobile APP or browser plugin)
 - Sepolia ETH available (gas fee for all the operations on our platform)
 - Ethereum network changed to Sepolia test network

:fire: Here are some resources where you can get free Sepolia ETH:
	
 - [Alchemy Sepolia Faucet](https://www.alchemy.com/faucets/ethereum-sepolia)
 - [Infura Sepolia Faucet](https://www.infura.io/faucet/sepolia)

## :mortar_board: How to use?
:pushpin: __Note:__ please watch the following instruction video at first.


[![Please watch this instruction video](https://img.youtube.com/vi/V5dHaQT7ybU/0.jpg)](https://www.youtube.com/watch?v=V5dHaQT7ybU)


- __How to set up the application?__ We have provided an [online application](https://smartreview1.netlify.app) for you, so you do not have to setup locally. \
   Please go to [:rocket: Quick Start](#rocket-quick-start) after finishing this section.
- __Any required library?__ No, this application has been deployed on cloud.
- __How to run it?__ Please follow the [demo video](https://www.youtube.com/watch?v=V5dHaQT7ybU) above, which walks through all the operations you can take.
- __How this application helps different types of users?__ We are proud to say that our application can adapt the general usage for all kinds of users who would like share their innovative ideas and leave reviews on these ideas which can then be voted to guarantee the quality. All the operations are incentivized.
- __About wallet?__ Please connect to your Metamask account to support any transaction on this platform. We use __sepolia__ as our testnet. Please get at least 0.01 SepoliaETH before connecting any operation since you need this to start any transaction

## :eyes: Front end Github repo
https://github.com/SmartReviewETH/smart-review-front-end

## 🗳️ Tally Link for DAO 
https://www.tally.xyz/gov/smartreview

## :computer: System Architecture
![Blank diagram (2)](https://github.com/SmartReviewETH/Smart-Review/assets/152730008/b2e87586-b3a3-48ab-a974-f923debff63e)

## :fire:  Why choose Smart-Review
### Problem Statement
 - Traditional review is not incentivized and therefore lacks participation from a broader audience, especially in the open source and scientific community
 - Bias from reviewers may hinder the wide adoption of cutting-edge work
 - Traditional reviews usually take longer to process
### Our Solutions
- Key features
	- SmartToken.sol [ERC-20 token](https://ethereum.org/en/developers/docs/standards/tokens/erc-20/)
	  We implemented our own ERC-20 token named **SmartToken**, with the symbol "**SMT**" [(view this token in Etherscan)](https://sepolia.etherscan.io/token/0xFb3901F9Fc06045f9cE03EeEB21485559A858784). The SMT tokens are rewarded to contributors in the community based on their roles and contributions as the following:
	
		- A reviewer will be rewarded if the proposals of his/her reviews are approved and executed after reaching a quorum in SmartReview DAO.
		- A member of the DAO will be rewarded if his/her voted proposals are approved and executed
	
	  The reward mechanism with cryptocurrency will significantly provide the incentivization, and encourage open-participation. We also have a faucet mechanism for getting free tokens to start.
	- SmartReviewContract.sol is used for providing basic data types and functions to support our application, such as initiating a smartReview, reviewing one's work, and completing the reviews/SmartReview.
	- GovernorContract.sol is used to manage proposals that are generated from reviews in our application. Our decision mechanism is based on token based voting, one token equals to one vote ([More](https://limechain.tech/blog/dao-voting-mechanisms-explained/) on voting machanism). SmartToken holders can interact with this contract to vote for, against or abstain on each proposal deciding whether or not the review is good enough. Once the proposal is passed, the predefined code will be executed and the reviewer can get the compensation. For each proposal there are some settings (current settings for test):
 		- Voting period (5 minutes): period of time allowed to vote.
		- Quorum needed (100 votes): minimum number of votes needed to pass the proposal.
		- Proposal threshold (1 token): munimum number of tokens needed to create proposal.
		- Queue: the period of time that the proposal is postaponed before execution, members can act accordingly in this time.
 	- SmartTokenFaucet.sol is used to provide free SmartTokens for new members. New members can get a certain amount of SmartTokens to start their journey on our platform.
 	- A user-friendly frontend to visualize all operations.
    - IPFS for distributed decentralized file storage.
- Target users include:
	- A researcher new to the research community and has some potential cutting-edge discoveries/inventions. He/she can submit his/her work on our platform and request reviews.
	- A researcher who wishes to get inspired by others' works and wishes to earn incentives by leave a review on our platform.
 	- A researcher who has an opinion on others' reviews and can participate in voting about the reviews.
	- Practitioners with other occupations with similar goals.


## :pager: Local setup instructions

- __Front-end Local Setup:__ You must install dependencies for our front end. Please clone our front-end repository at first, then switch to the root directory and run __npm install__ to install all required libraries, and run __npm start__ to start the front end. We have deployed all smart contracts for you.
- __Tests__: We use the front end for usability tests and all the functionality has been achieved.
- __Smart contracts Setup__: This repository holds all smart contracts for this application, you can first clone this repository in the [Remix](https://remix.ethereum.org/), a browser-embedded IDE for smart contracts implemented with Solidity. Then compile and deploy each smart contract by the following steps:
	- Compile the SmartToken contract, and then deploy it.
 	- Compile the SmartTokenFacet contract, and then deploy it.
  	- Compile the TimeLock contract, and then deploy it.
  	- Compile the GovernorContract contract, provide the address of the SmartToken contract and then deploy it. Remember to grant TimeLock roles to the Governor, otherwise the Governor can't perform correctly. Please check [this](https://docs.openzeppelin.com/defender/v1/guide-timelock-roles) for TimeLock Role explainations.
 	- Compile the SmartReviewContract contract, and provide the address of the SmartToken contract to the SmartReviewContract contract to deploy it.

## :heavy_exclamation_mark: Acknowledgement

To build our project, we have been inspired by some previous works.
 - [AntsReview](https://github.com/naszam/ants-review)
 	- allow issuers to issue an AntReview
  	- a bounty for peer-review in scientific publication
   	- linked to requirements stored on ipfs which peer-reviewers can fulfill by submitting the IPFS hash which contains evidence of their fulfillment
	- after the submission of successful peer-reviews, they will be approved by an approver and payed in ANTS
   We designed our workflow based on the framework of this project. But we have added our own components, such as review request proposal, review completion, voting mechanism, etc.

