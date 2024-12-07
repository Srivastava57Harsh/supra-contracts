module 0x335faef3a35932c83b5a2f7cff5edee7a9ff38bcb5c1ad6dc176e43ebd9af471::custom_token_testing_nine {
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
        
        let coins = coin::mint(initial_supply, &mint_cap);
        
        // Register and deposit to token_owner
        if (!coin::is_account_registered<TokenType>(token_owner)) {
            // If not registered, burn the coins using burn_cap
            coin::burn(coins, &burn_cap);
        } else {
            coin::deposit(token_owner, coins);
        };
        
        (burn_cap, freeze_cap, mint_cap)
    }

    // Rest of the code remains the same...
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