module 0x335faef3a35932c83b5a2f7cff5edee7a9ff38bcb5c1ad6dc176e43ebd9af471::token_factory_gamma_testing_nine {
    use std::string::String;
    use std::signer;
    use std::vector;
    use supra_framework::coin;
    use 0x335faef3a35932c83b5a2f7cff5edee7a9ff38bcb5c1ad6dc176e43ebd9af471::custom_token_testing_nine::{Self, Token0, Token1, Token2, Token3, Token4};
    
    struct TokenRecord has key {
        deployed_tokens: vector<TokenInfo>,
        current_index: u64
    }

    struct TokenInfo has store, drop, copy {
        token_address: address,
        name: String,
        symbol: String,
        creator: address
    }

    const MAX_TOKENS: u64 = 10;
    const E_MAX_TOKENS_REACHED: u64 = 1;

    public entry fun initialize(admin: &signer) {
        move_to(admin, TokenRecord {
            deployed_tokens: vector::empty(),
            current_index: 0
        });
    }

    public entry fun create_token(
        factory: &signer,
        token_owner: address,  // NEW: Separate owner parameter
        name: String,
        symbol: String,
        initial_supply: u64
    ) acquires TokenRecord {
        let factory_addr = signer::address_of(factory);
        let token_record = borrow_global_mut<TokenRecord>(factory_addr);
        assert!(token_record.current_index < MAX_TOKENS, E_MAX_TOKENS_REACHED);

        if (token_record.current_index == 0) {
            deploy_specific_token<Token0>(factory, token_owner, name, symbol, initial_supply, token_record);
        } else if (token_record.current_index == 1) {
            deploy_specific_token<Token1>(factory, token_owner, name, symbol, initial_supply, token_record);
        } else if (token_record.current_index == 2) {
            deploy_specific_token<Token2>(factory, token_owner, name, symbol, initial_supply, token_record);
        } else if (token_record.current_index == 3) {
            deploy_specific_token<Token3>(factory, token_owner, name, symbol, initial_supply, token_record);
        } else if (token_record.current_index == 4) {
            deploy_specific_token<Token4>(factory, token_owner, name, symbol, initial_supply, token_record);
        };
    }

    fun deploy_specific_token<TokenType: key + store + copy + drop>(
        factory: &signer,
        token_owner: address,
        name: String,
        symbol: String,
        initial_supply: u64,
        token_record: &mut TokenRecord
    ) {
        let (burn_cap, freeze_cap, mint_cap) = custom_token_testing_nine::initialize<TokenType>(
            factory,
            token_owner,  // Pass token_owner to initialize
            name,
            symbol,
            initial_supply
        );

        vector::push_back(&mut token_record.deployed_tokens, TokenInfo {
            token_address: token_owner,  // Record token_owner as the address
            name,
            symbol,
            creator: token_owner
        });
        token_record.current_index = token_record.current_index + 1;

        coin::destroy_burn_cap(burn_cap);
        coin::destroy_freeze_cap(freeze_cap);
        coin::destroy_mint_cap(mint_cap);
    }

    #[view]
    public fun get_deployed_tokens(creator: address): vector<TokenInfo> acquires TokenRecord {
        if (!exists<TokenRecord>(creator)) {
            return vector::empty()
        };
        borrow_global<TokenRecord>(creator).deployed_tokens
    }
}