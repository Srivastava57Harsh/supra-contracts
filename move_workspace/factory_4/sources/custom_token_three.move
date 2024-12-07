module 0x335faef3a35932c83b5a2f7cff5edee7a9ff38bcb5c1ad6dc176e43ebd9af471::custom_token_testing_three {
    use supra_framework::coin;
    use std::string::String;
    use std::vector;

    struct Token0 has key, store, copy, drop {}
    struct Token1 has key, store, copy, drop {}
    struct Token2 has key, store, copy, drop {}
    struct Token3 has key, store, copy, drop {}
    struct Token4 has key, store, copy, drop {}

    public fun initialize<TokenType: key + store + copy + drop>(
        creator: &signer,
        name: String,
        symbol: String,
        decimals: u8
    ): (coin::BurnCapability<TokenType>, coin::FreezeCapability<TokenType>, coin::MintCapability<TokenType>) {
        coin::initialize<TokenType>(
            creator,
            name,
            symbol,
            decimals,
            true
        )
    }

    // Function to transfer to two destinations
    public entry fun two_by_two<TokenType: key + store>(
        sender: &signer,
        amount: u64,
        dst_first: address,
        dst_second: address,
    ) {
        coin::transfer<TokenType>(sender, dst_first, amount);
        coin::transfer<TokenType>(sender, dst_second, amount);
    }

    // Multi transfer function
    public entry fun multi_transfer<TokenType: key + store>(
        sender: &signer,
        amount_per_address: u64,
        destinations: vector<address>
    ) {
        let i = 0;
        let total_addresses = vector::length(&destinations);
        
        while (i < total_addresses) {
            let dest = *vector::borrow(&destinations, i);
            coin::transfer<TokenType>(
                sender,
                dest,
                amount_per_address
            );
            i = i + 1;
        }
    }

    // Five address transfer
    public entry fun multi_transfer_five<TokenType: key + store>(
        sender: &signer,
        amount_per_address: u64,
        dest1: address,
        dest2: address,
        dest3: address,
        dest4: address,
        dest5: address
    ) {
        coin::transfer<TokenType>(sender, dest1, amount_per_address);
        coin::transfer<TokenType>(sender, dest2, amount_per_address);
        coin::transfer<TokenType>(sender, dest3, amount_per_address);
        coin::transfer<TokenType>(sender, dest4, amount_per_address);
        coin::transfer<TokenType>(sender, dest5, amount_per_address);
    }

    #[view]
    public fun view_balance<TokenType: key + store>(address: address): u64 {
        coin::balance<TokenType>(address)
    }
}