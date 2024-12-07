module exampleAddress::token_factory_beta {
    use std::string::String;
    use std::signer;
    use std::vector;
    use supra_framework::coin::{Self, BurnCapability, FreezeCapability, MintCapability};
    
    // Track deployed tokens
    struct TokenRecord has key {
        deployed_tokens: vector<TokenInfo>
    }

    // Info for each deployed token
    struct TokenInfo has store, drop, copy {
        token_address: address,
        name: String,
        symbol: String,
        creator: address,
        token_id: u64
    }

    // Unique token type for each deployment
    struct UniqueToken<phantom T> has key {}

    // Actual token type that gets created
    struct TokenType<phantom T> {}

    // Counter for unique token types
    struct TokenCounter has key {
        count: u64
    }

    // Initialize factory
    public entry fun initialize(admin: &signer) {
        move_to(admin, TokenRecord {
            deployed_tokens: vector::empty()
        });
        move_to(admin, TokenCounter { count: 0 });
    }

    // Deploy new token instance
    public entry fun deploy_new_token(
        creator: &signer,
        name: String,
        symbol: String,
        decimals: u8
    ) acquires TokenRecord, TokenCounter {
        let creator_addr = signer::address_of(creator);
        
        // Get unique token counter
        let counter = borrow_global_mut<TokenCounter>(creator_addr);
        let token_id = counter.count;
        counter.count = token_id + 1;

        // Use TokenType with counter as type parameter
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<TokenType<UniqueToken<u64>>>(
            creator,
            name,
            symbol,
            decimals,
            true
        );

        let token_record = borrow_global_mut<TokenRecord>(creator_addr);
        vector::push_back(&mut token_record.deployed_tokens, TokenInfo {
            token_address: creator_addr,
            name,
            symbol,
            creator: creator_addr,
            token_id
        });

        coin::destroy_burn_cap(burn_cap);
        coin::destroy_freeze_cap(freeze_cap);
        coin::destroy_mint_cap(mint_cap);
    }

    // View deployed tokens
    #[view]
    public fun get_deployed_tokens(creator: address): vector<TokenInfo> acquires TokenRecord {
        borrow_global<TokenRecord>(creator).deployed_tokens
    }
}