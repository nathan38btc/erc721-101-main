pragma solidity ^0.6.0;


import "./IExerciceSolution.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract mysolutionerc721 is IExerciceSolution,ERC721 {

    address public proprio;
    uint256 public NFTnumber;
    uint256 public Breederprice;

    struct Animal{ // NFT particularities
        string name;
        bool wings;
        uint legs;
        uint sex;
    }

    struct SaleDetail { // NFT sale informations
        bool IsforSale;
        uint price;
    }


    mapping(uint => Animal) public NFTdetails; // link a NFT to its details.
    mapping(uint => SaleDetail) public NFTSaleDetails;
    mapping(address => bool) public breeder;



    constructor (string memory name_, string memory symbol_,uint _price) ERC721(name_,symbol_) public {
        breeder[msg.sender] = true;
        Breederprice = _price;
        NFTnumber = 1;
        
    }


    modifier ContractBreeder(){
        require(breeder[msg.sender] == true,"This account doesn't have the right to create Animal Token");
        _;
    }

    // function for Animal creation 

    function Creation(address _to,string memory _name,bool _wings,uint _legs,uint _sex) public ContractBreeder {

        _mint(_to, NFTnumber);
        Animal storage a = NFTdetails[NFTnumber];

        NFTnumber = NFTnumber + 1;
        
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
        return Breederprice;
    }

	function registerMeAsBreeder() external override payable{
        require(msg.value ==  this.registrationPrice(), "not the correct ether amount for being register as a breeder");
        breeder[msg.sender] = true; 
    }

	function declareAnimal(uint sex, uint legs, bool wings, string calldata name) external override returns (uint256){
        require(this.isBreeder(msg.sender));
        Creation(msg.sender, name, wings, legs, sex);
        return(NFTnumber-1);
    }

	function getAnimalCharacteristics(uint animalNumber) external override returns (string memory _name, bool _wings, uint _legs, uint _sex){
        Animal storage a = NFTdetails[animalNumber];
        return (a.name,a.wings,a.legs,a.sex);
    }

	function declareDeadAnimal(uint animalNumber) external override {
        require(ownerOf(animalNumber)==msg.sender);

        Animal storage a = NFTdetails[animalNumber];
        a.name = "";
        a.wings = false;
        a.legs = 0;
        a.sex = 0;

        _burn(animalNumber);
    }

	function tokenOfOwnerByIndex(address owner, uint256 index) public view override(IExerciceSolution,ERC721) returns (uint256){
            return ERC721.tokenOfOwnerByIndex(owner,index);
    }   

	// Selling functions
	function isAnimalForSale(uint animalNumber) external view override returns (bool){
        return NFTSaleDetails[animalNumber].IsforSale;
    }

	function animalPrice(uint animalNumber) external view override returns (uint256){
        return NFTSaleDetails[animalNumber].price;
    }

	function buyAnimal(uint animalNumber) external payable override {
        require(NFTSaleDetails[animalNumber].IsforSale);
        require(msg.value == NFTSaleDetails[animalNumber].price);
// manage the aproval for the transfert !!!!!!!!!!!!!!
        transferFrom(ownerOf(animalNumber), msg.sender, animalNumber);
    }

	function offerForSale(uint animalNumber, uint price) external override {
        require(msg.sender == ownerOf(animalNumber),"you are not the owner of the nft");
        NFTSaleDetails[animalNumber].price = price;
        NFTSaleDetails[animalNumber].IsforSale = true;
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