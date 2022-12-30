pragma solidity ^0.6.0;


import "./IExerciceSolution.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract mysolutionerc721 is IExerciceSolution,ERC721 {

    struct Animal{ // NFT particularities
        string name;
        bool wings;
        uint legs;
        uint sex;
    }

    mapping(uint => Animal) public NFTdetails; // link a NFT to its detail.
    mapping(address => bool) public breeder;

    address public proprio;



    constructor (string memory name_, string memory symbol_) ERC721(name_,symbol_) public {
        proprio = msg.sender;
    }


    modifier ContractOwner(){
        require(msg.sender == proprio,"This account doesn't have the right to create Animal Token");
        _;
    }
    
    // function for Animal creation 

    function Creation(address _to,uint _id,string memory _name,bool _wings,uint _legs,uint _sex) public ContractOwner {
        _mint(_to, _id);

        Animal storage a = NFTdetails[_id];

        a.name = _name;
        a.wings=_wings;
        a.legs = _legs;
        a.sex=_sex;

    }


    //function of IExerciceSolution.sol function :
    function isBreeder(address account) external  override returns (bool){
        return breeder[account];
    }

	function registrationPrice() external override returns (uint256){
        return 0.0001 ether;
    }

	function registerMeAsBreeder() external override payable{
        require(msg.value > this.registrationPrice());
        breeder[msg.sender] = true;
    }

	function declareAnimal(uint sex, uint legs, bool wings, string calldata name) external override returns (uint256){

    }

	function getAnimalCharacteristics(uint animalNumber) external override returns (string memory _name, bool _wings, uint _legs, uint _sex){
        Animal storage a = NFTdetails[animalNumber];
        return (a.name,a.wings,a.legs,a.sex);
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