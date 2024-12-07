module 0x335faef3a35932c83b5a2f7cff5edee7a9ff38bcb5c1ad6dc176e43ebd9af471::custom_token_testing_five {
    use supra_framework::coin;
    use std::string::String;
    use std::vector;
    use std::signer;

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

    // Simple direct transfer
    public entry fun transfer<TokenType: key + store>(
        from: &signer,
        to: address,
        amount: u64
    ) {
        assert!(coin::is_account_registered<TokenType>(to), 1); // Check if recipient is registered
        coin::transfer<TokenType>(from, to, amount);
    }

    // Register function
    public entry fun register<TokenType: key + store>(account: &signer) {
        if (!coin::is_account_registered<TokenType>(signer::address_of(account))) {
            coin::register<TokenType>(account);
        }
    }

    #[view]
    public fun view_balance<TokenType: key + store>(address: address): u64 {
        coin::balance<TokenType>(address)
    }
}