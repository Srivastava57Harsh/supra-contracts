module 0x335faef3a35932c83b5a2f7cff5edee7a9ff38bcb5c1ad6dc176e43ebd9af471::custom_token_testing_two {
    use supra_framework::coin;
    use std::signer;
    use std::string::String;
    use std::vector;

    // Create unique token types for each deployment
    struct Token0 has key, store, copy, drop {}
    struct Token1 has key, store, copy, drop {}
    struct Token2 has key, store, copy, drop {}
    struct Token3 has key, store, copy, drop {}
    struct Token4 has key, store, copy, drop {}
    // ... add more if needed

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
}