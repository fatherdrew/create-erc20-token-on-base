Go into remix and use 0.8.20 compiler

Before compiling Change these

line 10 contract HelloToken
Change HelloToken to your new token name.

Line 18 constructor() ERC20("HelloToken", "HELLO") Ownable(msg.sender) { 
Change HelloTOken to new token name and HELLO to new token symbol - Keep it 3 to 4 characters

Line 19 _mint(msg.sender, 100000000000000000000000000000000000000000000000000000000000000000000000000000 * 10**decimals());
Change 10000000000000000000000000000000000000000000000000000000000000000000 to the amount you want and add 10 0's to it

After compiling go to button below compile to deploy section
Use Injected provider - metamask to create contract

Press Deploy and watch your token contract being created
When created, go back to metamask where activity is and press the transaction then hit view on explorer and wahlah.

For this example, here is the link to created token
https://basescan.org/tx/0x2769331839c36b27451722381cc9f64135d4766d4150bf1fe1e64746427382b9

Reason for doing this is because it cost literally less than a cent to a few cents to create a contract as opposed to spending alot on eth mainnet.
