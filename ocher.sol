pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract ocher {

	// State variable storing the sum of arguments that were passed to function 'add',
	string[] NameArray = ["Name1", "Name2", "Name3"];

	constructor() public {
		// check that contract's public key is set
		require(tvm.pubkey() != 0, 101);
		// Check that message has signature (msg.pubkey() is not zero) and message is signed with the owner's private key
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}

	// Modifier that allows to accept some external messages
	modifier checkOwnerAndAccept {
		// Check that message was signed with contracts key.
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}


	function addName(string value) public checkOwnerAndAccept {
			NameArray.push(value);
	}

	function delName() public checkOwnerAndAccept returns (string){
	    string str1="";
		str1=NameArray[0];
	    for (uint i = 0; i<NameArray.length-1; i++){
            NameArray[i] = NameArray[i+1];
        }
		NameArray.pop();
		return "Ochered-"+str1;
	}

	function printName() public checkOwnerAndAccept returns (string){
		string str1="";
		for (uint i = 0; i < NameArray.length; i++) {
			str1+=NameArray[i] + "-";
		}
		return str1;
	}

}

