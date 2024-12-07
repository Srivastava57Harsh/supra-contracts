module 0x335faef3a35932c83b5a2f7cff5edee7a9ff38bcb5c1ad6dc176e43ebd9af471::token_factory_gamma_testing_four {
    use std::string::String;
    use std::signer;
    use std::vector;
    use supra_framework::coin;
    use 0x335faef3a35932c83b5a2f7cff5edee7a9ff38bcb5c1ad6dc176e43ebd9af471::custom_token_testing_four::{Self, Token0, Token1, Token2, Token3, Token4};
    
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
    const INITIAL_SUPPLY: u64 = 1000000000;

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
        
        if (!exists<TokenRecord>(creator_addr)) {
            move_to(creator, TokenRecord {
                deployed_tokens: vector::empty(),
                current_index: 0
            });
        };
        
        let token_record = borrow_global_mut<TokenRecord>(creator_addr);
        assert!(token_record.current_index < MAX_TOKENS, E_MAX_TOKENS_REACHED);

        if (token_record.current_index == 0) {
            deploy_specific_token<Token0>(creator, name, symbol, decimals, token_record);
        } else if (token_record.current_index == 1) {
            deploy_specific_token<Token1>(creator, name, symbol, decimals, token_record);
        } else if (token_record.current_index == 2) {
            deploy_specific_token<Token2>(creator, name, symbol, decimals, token_record);
        } else if (token_record.current_index == 3) {
            deploy_specific_token<Token3>(creator, name, symbol, decimals, token_record);
        } else if (token_record.current_index == 4) {
            deploy_specific_token<Token4>(creator, name, symbol, decimals, token_record);
        };
    }

    fun deploy_specific_token<TokenType: key + store + copy + drop>(
        creator: &signer,
        name: String,
        symbol: String,
        decimals: u8,
        token_record: &mut TokenRecord
    ) {
        let creator_addr = signer::address_of(creator);
        let (burn_cap, freeze_cap, mint_cap) = custom_token_testing_four::initialize<TokenType>(
            creator,
            name,
            symbol,
            decimals
        );

        let coins = coin::mint<TokenType>(INITIAL_SUPPLY, &mint_cap);
        coin::register<TokenType>(creator);
        coin::deposit(creator_addr, coins);

        vector::push_back(&mut token_record.deployed_tokens, TokenInfo {
            token_address: creator_addr,
            name,
            symbol,
            creator: creator_addr
        });
        token_record.current_index = token_record.current_index + 1;

        coin::destroy_burn_cap(burn_cap);
        coin::destroy_freeze_cap(freeze_cap);
        coin::destroy_mint_cap(mint_cap);
    }

    #[view]
    public fun get_deployed_tokens(creator: address): vector<TokenInfo> acquires TokenRecord {
        borrow_global<TokenRecord>(creator).deployed_tokens
    }
}