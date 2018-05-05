
contract ProofOfExistence {

    address public owner;
    mapping(address => bytes32) public hashes;     

    function ProofOfExistance(){
        owner = msg.sender;
    }

    modifier isAdmin(){
        require(owner == msg.sender);
        _;
    }

    function RegisterHash(string input){
        hashes[msg.sender] = keccak256(input);
    }

    function GetHashSting(address _address) view returns (string){
        return bytes32ToString(hashes[_address]);
    }

    function bytes32ToString(bytes32 x) constant returns (string) {
        bytes memory bytesString = new bytes(32);
        uint charCount = 0;
        for (uint j = 0; j < 32; j++) {
            byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
            if (char != 0) {
                bytesString[charCount] = char;
                charCount++;
            }
        }
        bytes memory bytesStringTrimmed = new bytes(charCount);
        for (j = 0; j < charCount; j++) {
            bytesStringTrimmed[j] = bytesString[j];
        }
        return string(bytesStringTrimmed);
    }

    function kill() isAdmin{
        selfdestruct(owner);
    }
}