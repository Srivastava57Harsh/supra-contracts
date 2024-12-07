module 0xdc167abaaeefe34ca7426b800d6099584d4db56851b7dabb5c1d50925b691918::token_factory_gamma_testing_twelve {
    use std::string::String;
    use std::signer;
    use std::vector;
    use supra_framework::coin;
    use 0xdc167abaaeefe34ca7426b800d6099584d4db56851b7dabb5c1d50925b691918::custom_token_testing_twelve::{Self, Token0, Token1, Token2, Token3, Token4};
    
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
    const E_NOT_INITIALIZED: u64 = 2;

    public entry fun initialize(admin: &signer) {
        if (!exists<TokenRecord>(signer::address_of(admin))) {
            move_to(admin, TokenRecord {
                deployed_tokens: vector::empty(),
                current_index: 0
            });
        }
    }

    public entry fun create_token(
        factory: &signer,
        token_owner: address,
        name: String,
        symbol: String,
        initial_supply: u64
    ) acquires TokenRecord {
        let token_record = borrow_global_mut<TokenRecord>(signer::address_of(factory));
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
        }
    }

    fun deploy_specific_token<TokenType: key + store + copy + drop>(
        factory: &signer,
        token_owner: address,
        name: String,
        symbol: String,
        initial_supply: u64,
        token_record: &mut TokenRecord
    ) {
        let (burn_cap, freeze_cap, mint_cap) = custom_token_testing_twelve::initialize<TokenType>(
            factory,
            token_owner,
            name,
            symbol,
            initial_supply
        );

        vector::push_back(&mut token_record.deployed_tokens, TokenInfo {
            token_address: token_owner,
            name,
            symbol,
            creator: token_owner
        });
        token_record.current_index = token_record.current_index + 1;

        coin::destroy_burn_cap<TokenType>(burn_cap);
        coin::destroy_freeze_cap<TokenType>(freeze_cap);
        coin::destroy_mint_cap<TokenType>(mint_cap);
    }

    #[view]
    public fun get_deployed_tokens(creator: address): vector<TokenInfo> acquires TokenRecord {
        assert!(exists<TokenRecord>(creator), E_NOT_INITIALIZED);
        borrow_global<TokenRecord>(creator).deployed_tokens
    }
}