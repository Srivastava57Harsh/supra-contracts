module 0x335faef3a35932c83b5a2f7cff5edee7a9ff38bcb5c1ad6dc176e43ebd9af471::custom_token_testing_seven {
    use supra_framework::coin;
    use std::string::String;
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
        initial_supply: u64
    ): (coin::BurnCapability<TokenType>, coin::FreezeCapability<TokenType>, coin::MintCapability<TokenType>) {
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<TokenType>(
            creator,
            name,
            symbol,
            8, // decimals like ERC20
            true
        );
        
        // Mint initial supply to creator
        let coins = coin::mint(initial_supply, &mint_cap);
        coin::register<TokenType>(creator);
        coin::deposit(signer::address_of(creator), coins);
        
        (burn_cap, freeze_cap, mint_cap)
    }

    // Transfer function
    public entry fun transfer<TokenType: key + store>(
        from: &signer,
        to: address,
        amount: u64
    ) {
        coin::transfer<TokenType>(from, to, amount);
    }

    #[view]
    public fun balance<TokenType: key + store>(owner: address): u64 {
        coin::balance<TokenType>(owner)
    }
}