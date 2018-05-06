var ProofOfExistence = artifacts.require("ProofOfExistence");
var ProofOfExistenceInstance;
var hashStringInput;
var hashStringOutout;

contract('ProofOfExistence', function(accounts) {
    it("test ProofOfExistence register hash", function() {
        return ProofOfExistence.deployed().then(function(instance) {
            ProofOfExistenceInstance = instance;
            return ProofOfExistenceInstance.GetHashFromString("Hello World", {from: accounts[0]});             
        }).then(function(result) {
            hashStringInput = result;
            return ProofOfExistenceInstance.RegisterHash(hashStringInput, {from: accounts[0]});             
        }).then(function(result) {
            return ProofOfExistenceInstance.GetHashString(accounts[0], {from: accounts[0]});             
        }).then(function(result) {
            hashStringOutout = result;
            assert.equal(hashStringInput, hashStringOutout, "Hashes are equal");            
        });
    });
});