from web3 import Web3
import json

# Replace with your Infura API key and contract address
infura_url = 'http://127.0.0.1:7545'
contract_address = '0xE0814e726fB8e884e644be1763504dE2Ef9321ab'

# Replace with your private key
private_key = '0xf74d6f44cbd3884b4d5bc803537a4317e620ce5ed04848b17a459d866f882370'

# Connect to the Ethereum node using Infura
w3 = Web3(Web3.HTTPProvider(infura_url))

# Check if connected to the node
if w3.is_connected():
    # Load the contract ABI and address
    with open('build/contracts/Arisan.json') as f:  # Replace with your ABI file
        contract_abi = json.load(f)
    
    contract = w3.eth.contract(address=contract_address, abi=contract_abi)

    # Arisan amount to send with the transaction
    arisan_amount = 1  # replace with the desired amount

    # Replace with the actual gas price and gas limit values
    gas_price = w3.toWei('10', 'gwei')
    gas_limit = 100000

    # Replace with the actual account address
    account_address = '0xa1b6cBe08111e46bf7B4da578505C17EdA3867B3'

    # Build the transaction
    transaction = contract.functions.joinArisan().buildTransaction({
        'from': account_address,
        'gas': gas_limit,
        'gasPrice': gas_price,
        'nonce': w3.eth.getTransactionCount(account_address),
        'value': w3.toWei(arisan_amount, 'ether'),  # Set the correct arisan amount in Ether
    })

    # Sign the transaction
    signed_transaction = w3.eth.account.sign_transaction(transaction, private_key)

    # Send the transaction
    transaction_hash = w3.eth.sendRawTransaction(signed_transaction.rawTransaction)
    
    print(f'Transaction sent. Transaction Hash: {transaction_hash.hex()}')
else:
    print('Unable to connect to the Ethereum node')
