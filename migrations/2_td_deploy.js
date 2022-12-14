const Str = require('@supercharge/strings')
// const BigNumber = require('bignumber.js');

var TDErc20 = artifacts.require("ERC20TD.sol");
var evaluator2 = artifacts.require("Evaluator2.sol");
var mysolutionerc721 = artifacts.require("MySolutionErc721.sol");


module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        await deployTDToken(deployer, network, accounts); 
        await deployEvaluator(deployer, network, accounts); 
        await setPermissionsAndRandomValues(deployer, network, accounts); 
        //await deployRecap(deployer, network, accounts); 

		await SubmitExercice(deployer,network,accounts,{from:accounts[0]});
        await Evaluator2.ex2a_getAnimalToCreateAttributes();

        await mySolucErc721.Creation(Evaluator2.address,"nothere",true,5,6);
        await mySolucErc721.Creation(accounts[0],"nothereeither",false,8,7);

    
        //await Evaluator2.ex7a_breedAnimalWithParents(1,2);
        //await Evaluator2.ex7b_offerAnimalForReproduction();

        

        await web3.eth.personal.sendTransaction({from : accounts[0],to : Evaluator2.address,value : web3.utils.toBN(web3.utils.toWei("0.0015", "ether"))});
        const dm = await mySolucErc721.offerForReproduction(3,web3.utils.toBN(web3.utils.toWei("0.001","ether")));

        await Evaluator2.ex7c_payForReproduction(3);
		await MyPoints(deployer,network,accounts); 

    });
};

async function deployTDToken(deployer, network, accounts) {
	TDToken = await TDErc20.new("TD-ERC721-101","TD-ERC721-101",web3.utils.toBN("0"))
	// TDToken = await TDErc20.at("0x46a9Dc47185F769ef9a11927B0f9d2fd0dEc3304")
}

async function deployEvaluator(deployer, network, accounts) {
	// Evaluator = await evaluator.at("0x6B19d275dA33857a3f35F7c1034048Ba1abF75CD") 
	Evaluator2 = await evaluator2.new(TDToken.address)
}

async function setPermissionsAndRandomValues(deployer, network, accounts) {
	await TDToken.setTeacher(Evaluator2.address, true)
	randomNames = []
	randomLegs = []
	randomSex = []
	randomWings = []
	for (i = 0; i < 20; i++)
		{
		randomNames.push(Str.random(15))
		randomLegs.push(Math.floor(Math.random()*5))
		randomSex.push(Math.floor(Math.random()*2))
		randomWings.push(Math.floor(Math.random()*2))
		// randomTickers.push(web3.utils.utf8ToBytes(Str.random(5)))
		// randomTickers.push(Str.random(5))
		}

	// console.log(randomNames)
	// console.log(randomLegs)
	// console.log(randomSex)
	// console.log(randomWings)
	// console.log(web3.utils)
	// console.log(type(Str.random(5)0)
	await Evaluator2.setRandomValuesStore(randomNames, randomLegs, randomSex, randomWings);
}

async function deployRecap(deployer, network, accounts) {
	console.log("TDToken " + TDToken.address)
	console.log("Evaluator2 " + Evaluator2.address)
}

async function SubmitExercice(deployer,network,accounts) {
	mySolucErc721 = await mysolutionerc721.new("Balader","Bld",web3.utils.toBN(web3.utils.toWei("0.001","ether")))
	await Evaluator2.submitExercice(mySolucErc721.address,{from:accounts[0]})
}

async function MyPoints(deployer,network,accounts){   // print the number of points Obtained
	console.log("Marks = "+await TDToken.balanceOf(accounts[0])/1000000000000000000+"/20")
}


