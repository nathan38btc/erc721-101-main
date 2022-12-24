pragma solidity ^0.6.0;


import "./IExerciceSolution.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract mysolutionerc721 is IExerciceSolution,ERC721 {


    constructor (string memory name_, string memory symbol_,address evaluator) ERC721(name_,symbol_) public {
        _mint(evaluator, 1);
    }

    //function of IExerciceSolution.sol function :
    function isBreeder(address account) external override returns (bool){

    }

	function registrationPrice() external override returns (uint256){

    }

	function registerMeAsBreeder() external override payable{

    }

	function declareAnimal(uint sex, uint legs, bool wings, string calldata name) external override returns (uint256){

    }

	function getAnimalCharacteristics(uint animalNumber) external override returns (string memory _name, bool _wings, uint _legs, uint _sex){

    }

	function declareDeadAnimal(uint animalNumber) external override {

    }

	function tokenOfOwnerByIndex(address owner, uint256 index) public view override(IExerciceSolution,ERC721) returns (uint256){

    }

	// Selling functions
	function isAnimalForSale(uint animalNumber) external view override returns (bool){

    }

	function animalPrice(uint animalNumber) external view override returns (uint256){

    }

	function buyAnimal(uint animalNumber) external payable override {

    }

	function offerForSale(uint animalNumber, uint price) external override {

    }

	// Reproduction functions
	function declareAnimalWithParents(uint sex, uint legs, bool wings, string calldata name, uint parent1, uint parent2) external override returns (uint256){

    }

	function getParents(uint animalNumber) external override returns (uint256, uint256){

    }

	function canReproduce(uint animalNumber) external override returns (bool){

    }

	function reproductionPrice(uint animalNumber) external view override returns (uint256){

    }

	function offerForReproduction(uint animalNumber, uint priceOfReproduction) external override returns (uint256){

    }

	function authorizedBreederToReproduce(uint animalNumber) external override returns (address){

    }

	function payForReproduction(uint animalNumber) external payable override {

    }
}