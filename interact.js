const Web3 = require('web3');
const web3 = new Web3('http://localhost:8545'); // Change to your Ethereum node

const contractABI = [ /* Add the ABI JSON here */ ];
const contractAddress = '0xYourDeployedContractAddress';
const votingContract = new web3.eth.Contract(contractABI, contractAddress);

async function vote(candidateIndex, fromAddress) {
    try {
        await votingContract.methods.vote(candidateIndex).send({ from: fromAddress });
        console.log('Vote cast successfully');
    } catch (error) {
        console.error('Error casting vote:', error);
    }
}

async function getCandidates() {
    try {
        const candidates = await votingContract.methods.getCandidates().call();
        console.log('Candidates:', candidates);
    } catch (error) {
        console.error('Error fetching candidates:', error);
    }
}

module.exports = { vote, getCandidates };
