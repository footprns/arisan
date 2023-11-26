from web3 import Web3, AsyncWeb3
import os, json
from eth_account import Account
from web3.middleware import construct_sign_and_send_raw_middleware
from dotenv import load_dotenv
import os

w3 = Web3(Web3.HTTPProvider('http://127.0.0.1:7545'))

load_dotenv()


def send_eth(private_key, sender, receiver):

    # Specify the amount in wei (1 wei)
    amount_in_wei = 1
    nonce = w3.eth.get_transaction_count(sender)  
    tx = {
        'type': '0x2',
        'nonce': nonce,
        'from': sender,
        'to': receiver,
        'value': w3.to_wei(0.05, 'ether'),
        'maxFeePerGas': w3.to_wei('250', 'gwei'),
        'maxPriorityFeePerGas': w3.to_wei('3', 'gwei'),
        'chainId': 1337
    }
    gas = w3.eth.estimate_gas(tx)
    tx['gas'] = gas
    signed_tx = w3.eth.account.sign_transaction(tx, private_key)
    tx_hash = w3.eth.send_raw_transaction(signed_tx.rawTransaction)
    print("Transaction hash: " + str(w3.to_hex(tx_hash)))

def execute_arisan():
    # Load the contract ABI from the file
    with open('build/contracts/Arisan.json', 'r') as abi_file:
        contract_abi = json.load(abi_file)
    abi = contract_abi["abi"]
    deployed_contract = w3.eth.contract(address=os.environ['arisan_sc'], abi=abi)
    deployed_contract.functions.withdraw(500000000000000000).transact({'from': os.environ['owner2']})  
    # print(deployed_contract.functions.getRemainingTime().call())  

# send_eth(private_key=os.environ['owner2_privkey'], sender=os.environ['owner2'], receiver=os.environ['arisan_sc'])
execute_arisan()

