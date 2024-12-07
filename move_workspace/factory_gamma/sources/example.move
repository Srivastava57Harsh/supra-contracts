module exampleAddress::token_factory_gamma {
    use std::string::{Self, String};
    use std::signer;
    use std::vector;
    use supra_framework::coin::{Self};
    
    struct TokenRecord has key {
        deployed_tokens: vector<TokenInfo>,
        current_index: u64  // Track which token type to use next
    }

    struct TokenInfo has store, drop, copy {
        token_address: address,
        name: String,
        symbol: String,
        creator: address
    }

    // 10 unique token types
    struct Token0 has key, store, copy, drop {} 
    struct Token1 has key, store, copy, drop {}
    struct Token2 has key, store, copy, drop {}
    struct Token3 has key, store, copy, drop {}
    struct Token4 has key, store, copy, drop {}
    struct Token5 has key, store, copy, drop {}
    struct Token6 has key, store, copy, drop {}
    struct Token7 has key, store, copy, drop {}
    struct Token8 has key, store, copy, drop {}
    struct Token9 has key, store, copy, drop {}

    const MAX_TOKENS: u64 = 10;
    const E_MAX_TOKENS_REACHED: u64 = 1;

    public entry fun initialize(admin: &signer) {
        move_to(admin, TokenRecord {
            deployed_tokens: vector::empty(),
            current_index: 0
        });
    }

    public entry fun deploy_token(
        creator: &signer,
        name: String,
        symbol: String,
        decimals: u8
    ) acquires TokenRecord {
        let creator_addr = signer::address_of(creator);
        let token_record = borrow_global_mut<TokenRecord>(creator_addr);
        
        assert!(token_record.current_index < MAX_TOKENS, E_MAX_TOKENS_REACHED);
        let current = token_record.current_index;
        token_record.current_index = current + 1;

        // Deploy using the appropriate token type
        if (current == 0) {
            deploy_specific_token<Token0>(creator, name, symbol, decimals, token_record);
        } else if (current == 1) {
            deploy_specific_token<Token1>(creator, name, symbol, decimals, token_record);
        } else if (current == 2) {
            deploy_specific_token<Token2>(creator, name, symbol, decimals, token_record);
        } else if (current == 3) {
            deploy_specific_token<Token3>(creator, name, symbol, decimals, token_record);
        } else if (current == 4) {
            deploy_specific_token<Token4>(creator, name, symbol, decimals, token_record);
        } else if (current == 5) {
            deploy_specific_token<Token5>(creator, name, symbol, decimals, token_record);
        } else if (current == 6) {
            deploy_specific_token<Token6>(creator, name, symbol, decimals, token_record);
        } else if (current == 7) {
            deploy_specific_token<Token7>(creator, name, symbol, decimals, token_record);
        } else if (current == 8) {
            deploy_specific_token<Token8>(creator, name, symbol, decimals, token_record);
        } else if (current == 9) {
            deploy_specific_token<Token9>(creator, name, symbol, decimals, token_record);
        };
    }

    fun deploy_specific_token<T>(
        creator: &signer,
        name: String,
        symbol: String,
        decimals: u8,
        token_record: &mut TokenRecord,
    ) {
        let creator_addr = signer::address_of(creator);
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<T>(
            creator,
            name,
            symbol,
            decimals,
            true
        );

        vector::push_back(&mut token_record.deployed_tokens, TokenInfo {
            token_address: creator_addr,
            name,
            symbol,
            creator: creator_addr
        });

        coin::destroy_burn_cap(burn_cap);
        coin::destroy_freeze_cap(freeze_cap);
        coin::destroy_mint_cap(mint_cap);
    }

    #[view]
    public fun get_deployed_tokens(creator: address): vector<TokenInfo> acquires TokenRecord {
        borrow_global<TokenRecord>(creator).deployed_tokens
    }

        public entry fun transfer<T>(
        from: &signer,
        to: address,
        amount: u64
    ) {
        if (!coin::is_account_registered<T>(to)) {
            coin::register<T>(to);
        };
        let coins = coin::withdraw<T>(from, amount);
        coin::deposit(to, coins);
    }

    // Get balance
    #[view]
    public fun get_balance<T>(owner: address): u64 {
        coin::balance<T>(owner)
    }

    // Register account to receive tokens
    public entry fun register<T>(account: &signer) {
        if (!coin::is_account_registered<T>(signer::address_of(account))) {
            coin::register<T>(account);
        }
    }
}