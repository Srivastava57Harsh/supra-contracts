module 0xdc167abaaeefe34ca7426b800d6099584d4db56851b7dabb5c1d50925b691918::custom_token_testing_twelve {
    use supra_framework::coin;
    use std::string::String;
    use std::signer;

    struct Token0 has key, store, copy, drop {}
    struct Token1 has key, store, copy, drop {}
    struct Token2 has key, store, copy, drop {}
    struct Token3 has key, store, copy, drop {}
    struct Token4 has key, store, copy, drop {}

    const E_NOT_REGISTERED: u64 = 1;
    const E_INSUFFICIENT_BALANCE: u64 = 2;

    public fun initialize<TokenType: key + store + copy + drop>(
        factory: &signer,
        token_owner: address,
        name: String,
        symbol: String,
        initial_supply: u64
    ): (coin::BurnCapability<TokenType>, coin::FreezeCapability<TokenType>, coin::MintCapability<TokenType>) {
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<TokenType>(
            factory,
            name,
            symbol,
            8,
            true
        );
        
        // Register for factory first
        if (!coin::is_account_registered<TokenType>(signer::address_of(factory))) {
            coin::register<TokenType>(factory);
        };
        
        // Mint coins to factory first
        let coins = coin::mint(initial_supply, &mint_cap);
        coin::deposit(signer::address_of(factory), coins);
        
        // Now transfer to token_owner if different from factory
        if (signer::address_of(factory) != token_owner) {
            if (!coin::is_account_registered<TokenType>(token_owner)) {
                coin::register<TokenType>(factory);
            };
            coin::transfer<TokenType>(factory, token_owner, initial_supply);
        };
        
        (burn_cap, freeze_cap, mint_cap)
    }

    public entry fun register<TokenType: key + store>(account: &signer) {
        if (!coin::is_account_registered<TokenType>(signer::address_of(account))) {
            coin::register<TokenType>(account);
        }
    }

    public entry fun transfer<TokenType: key + store>(
        from: &signer,
        to: address,
        amount: u64
    ) {
        assert!(coin::is_account_registered<TokenType>(to), E_NOT_REGISTERED);
        assert!(coin::balance<TokenType>(signer::address_of(from)) >= amount, E_INSUFFICIENT_BALANCE);
        coin::transfer<TokenType>(from, to, amount);
    }

    #[view]
    public fun balance<TokenType: key + store>(owner: address): u64 {
        coin::balance<TokenType>(owner)
    }

    #[view]
    public fun is_registered<TokenType: key + store>(addr: address): bool {
        coin::is_account_registered<TokenType>(addr)
    }
}