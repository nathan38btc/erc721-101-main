const Str = require('@supercharge/strings')
// const BigNumber = require('bignumber.js');

var TDErc20 = artifacts.require("ERC20TD.sol");
var evaluator = artifacts.require("Evaluator.sol");
var evaluator2 = artifacts.require("Evaluator2.sol");
var mysolutionerc721 = artifacts.require("MySolutionErc721.sol");


module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        await deployTDToken(deployer, network, accounts); 
        await deployEvaluator(deployer, network, accounts); 
        await setPermissionsAndRandomValues(deployer, network, accounts); 
        //await deployRecap(deployer, network, accounts); 

		await SubmitExercice(deployer,network,accounts,{from:accounts[0]});
		await mySolucErc721.Creation(Evaluator.address,1,"First token",2,4,1,{from: accounts[0]}); 

		await Evaluator.ex1_testERC721({from:accounts[0]});

		await Evaluator.ex2a_getAnimalToCreateAttributes({from:accounts[0]});

		await mySolucErc721.Creation(Evaluator.address,2,await Evaluator.readName(accounts[0]),await Evaluator.readWings(accounts[0]),await Evaluator.readLegs(accounts[0]),await Evaluator.readSex(accounts[0]),{from:accounts[0]});
		await Evaluator.ex2b_testDeclaredAnimal(2);

		await MyPoints(deployer,network,accounts); 

    });
};

async function deployTDToken(deployer, network, accounts) {
	TDToken = await TDErc20.new("TD-ERC721-101","TD-ERC721-101",web3.utils.toBN("0"))
	
	// TDToken = await TDErc20.at("0x46a9Dc47185F769ef9a11927B0f9d2fd0dEc3304")
}

async function deployEvaluator(deployer, network, accounts) {
	Evaluator = await evaluator.new(TDToken.address)
	// Evaluator = await evaluator.at("0x6B19d275dA33857a3f35F7c1034048Ba1abF75CD") 
	Evaluator2 = await evaluator2.new(TDToken.address)
}

async function setPermissionsAndRandomValues(deployer, network, accounts) {
	await TDToken.setTeacher(Evaluator.address, true)
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

	console.log(randomNames)
	console.log(randomLegs)
	console.log(randomSex)
	console.log(randomWings)
	// console.log(web3.utils)
	// console.log(type(Str.random(5)0)
	await Evaluator.setRandomValuesStore(randomNames, randomLegs, randomSex, randomWings);
	await Evaluator2.setRandomValuesStore(randomNames, randomLegs, randomSex, randomWings);
}

async function deployRecap(deployer, network, accounts) {
	console.log("TDToken " + TDToken.address)
	console.log("Evaluator " + Evaluator.address)
	console.log("Evaluator2 " + Evaluator2.address)
}

async function SubmitExercice(deployer,network,accounts) {
	var mySolucErc721 = await mysolutionerc721.new("Balader","Bld",await Evaluator.address)
	await Evaluator.submitExercice(mySolucErc721.address,{from:accounts[0]})
}

async function MyPoints(deployer,network,accounts){   // print the number of points Obtained
	console.log("Marks = "+await TDToken.balanceOf(accounts[0])/1000000000000000000+"/20")
}


