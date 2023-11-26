# arisan
A social gathering or a form of rotating savings and credit association

# How to use
## POC 1
1. There are 3 people that submit same amount 0.05 ether to a contract
2. The contract is lock for 1 day
3. Any of the people can withdraw after the locking period
4. Then the contract destroy


---
backup
from web3 import Web3

# Connect to your Ethereum node (replace 'your_node_url' with your actual node URL)
w3 = Web3(Web3.HTTPProvider('your_node_url'))

# Replace 'contract_address' with the actual address of your smart contract
contract_address = '0xYourContractAddress'

# Replace 'your_private_key' with the private key of your Ethereum account
private_key = '0xYourPrivateKey'

# Replace 'your_contract_abi' with the ABI of your smart contract
contract_abi = [
    {
        "constant": True,
        "inputs": [],
        "name": "getRemainingTime",
        "outputs": [{"name": "", "type": "uint256"}],
        "payable": False,
        "stateMutability": "view",
        "type": "function",
    }
]

# Create a contract instance
contract = w3.eth.contract(address=contract_address, abi=contract_abi)

# Replace 'your_account_address' with the address of your Ethereum account
account_address = '0xYourAccountAddress'

# Build the transaction
transaction = contract.functions.getRemainingTime().buildTransaction({
    'from': account_address,
    'gas': 200000,
    'gasPrice': w3.toWei('50', 'gwei'),  # Replace '50' with your desired gas price in gwei
    'nonce': w3.eth.getTransactionCount(account_address),
})

# Sign the transaction
signed_transaction = w3.eth.account.sign_transaction(transaction, private_key)

# Call the contract function using eth_call
result = w3.eth.call({
    'to': contract_address,
    'data': signed_transaction.rawTransaction
})

# Decode the result
remaining_time = int(result, 16)
print(f'Remaining Time: {remaining_time} seconds')
