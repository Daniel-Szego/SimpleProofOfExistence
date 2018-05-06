
contract ProofOfExistence {

    address public owner;
    mapping(address => string) public hashes;     

    function ProofOfExistance(){
        owner = msg.sender;
    }

    modifier isAdmin(){
        require(owner == msg.sender);
        _;
    }

    function RegisterHash(string _input){
        hashes[msg.sender] = _input;
    }

    function GetHashString(address _address) view returns (string){
        return hashes[_address];
    }

    function GetHashFromString(string _input) view returns (bytes32) {
        bytes32 hash = keccak256(_input);
        return hash;
    }

    function kill() isAdmin{
        selfdestruct(owner);
    }
}