module exampleAddress::custom_token {
    use supra_framework::coin;
    use std::signer;
    use std::account;
    use std::string::String;

    // Define token type
    struct TempToken has key {}

    // Initialize function that factory will call
    public fun initialize(
        creator: &signer,
        name: String,
        symbol: String,
        decimals: u8
    ): (coin::BurnCapability<TempToken>, coin::FreezeCapability<TempToken>, coin::MintCapability<TempToken>) {
        coin::initialize<TempToken>(
            creator,
            name,
            symbol,
            decimals,
            true  // configurable supply
        )
    }
    
    // Function to transfer to two destinations
    public entry fun two_by_two(
        first: &signer,
        amount_first: u64,
        dst_first: address,
        dst_second: address,
    ) {
        coin::transfer<TempToken>(first, dst_first, amount_first);
        coin::transfer<TempToken>(first, dst_second, amount_first);
    }

    // Function to view balance
    #[view]
    public fun view_balance(address: address): u64 {
        coin::balance<TempToken>(address)
    }

    // Multi transfer function
    public entry fun multi_transfer(
        sender: &signer,
        amount_per_address: u64,
        destinations: vector<address>
    ) {
        let i = 0;
        let total_addresses = std::vector::length(&destinations);
        
        while (i < total_addresses) {
            let dest = *std::vector::borrow(&destinations, i);
            coin::transfer<TempToken>(
                sender,
                dest,
                amount_per_address
            );
            i = i + 1;
        }
    }

    // Five address transfer
    public entry fun multi_transfer_five(
        sender: &signer,
        amount_per_address: u64,
        dest1: address,
        dest2: address,
        dest3: address,
        dest4: address,
        dest5: address
    ) {
        coin::transfer<TempToken>(sender, dest1, amount_per_address);
        coin::transfer<TempToken>(sender, dest2, amount_per_address);
        coin::transfer<TempToken>(sender, dest3, amount_per_address);
        coin::transfer<TempToken>(sender, dest4, amount_per_address);
        coin::transfer<TempToken>(sender, dest5, amount_per_address);
    }
}