pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract ltask {

	// State variable storing the sum of arguments that were passed to function 'add',
	int8[] key =[int8(1)];
	struct tasks{
		string name;
		uint32 addtime;
		bool flagv;
	}
	mapping(int8 => tasks) arraytask;

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

	// Function that adds its argument to the state variable.
	function add(string value) public checkOwnerAndAccept {
		if(value != ""){
			arraytask[key[key.length-1]] = tasks(value, now, false);
			key.push(key[key.length-1]+int8(1));
		}
	}

	function vsegoT() public checkOwnerAndAccept returns (int){
		 int vsego = 0;
		for (int8 i = 0; i < int8(key.length-1); i++) {
			if(arraytask[key[uint256(i)]].name!="" && arraytask[key[uint256(i)]].flagv==false){
				vsego+=1;
			}
		}
		return vsego;
	}

	function printT() public checkOwnerAndAccept returns (string){
		string str1;
		for (int8 i = 0; i < int8(key.length-1); i++) {
			if(arraytask[key[uint256(i)]].name!="" && arraytask[key[uint256(i)]].flagv==false){
				str1+=arraytask[key[uint256(i)]].name + ";";
			}
		}
		return str1;
	}

	function myprintT(int8 value) public checkOwnerAndAccept returns (string){
		return arraytask[value].name;
	}

	function del(int8 value) public checkOwnerAndAccept {
		int v1=0;
		int8 v2=0;
		uint v3=0;
		for (uint i = 0; i < key.length-1; i++) {
				if(key[i]==value){
				delete arraytask[key[i]];
				delete key[i];
				}
		}
		
	}

	function gotov(int8 value) public checkOwnerAndAccept {
		if(arraytask[value].name!=""){arraytask[value].flagv=true;}
	}


	
}