module exampleAddress::custom_token_two {
    use supra_framework::coin;
    use std::signer;
    use std::account;
    use std::string::String;
    use std::vector;

    struct TempToken has key, store, copy, drop {}

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
            true
        )
    }

    // Rest of your custom token functions remain the same
    public entry fun two_by_two(
        first: &signer,
        amount_first: u64,
        dst_first: address,
        dst_second: address,
    ) {
        coin::transfer<TempToken>(first, dst_first, amount_first);
        coin::transfer<TempToken>(first, dst_second, amount_first);
    }

    #[view]
    public fun view_balance(address: address): u64 {
        coin::balance<TempToken>(address)
    }

    public entry fun multi_transfer(
        sender: &signer,
        amount_per_address: u64,
        destinations: vector<address>
    ) {
        let i = 0;
        let total_addresses = vector::length(&destinations);
        
        while (i < total_addresses) {
            let dest = *vector::borrow(&destinations, i);
            coin::transfer<TempToken>(
                sender,
                dest,
                amount_per_address
            );
            i = i + 1;
        }
    }

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