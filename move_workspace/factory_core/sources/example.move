module exampleAddress::token_factory_core {
    use std::string::{Self, String};
    use std::signer;
    use std::vector;
    use supra_framework::coin::{Self, MintCapability};

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

    // Unique token types
    struct Token0 {} 
    struct Token1 {}
    struct Token2 {}
    struct Token3 {}
    struct Token4 {}
    struct Token5 {}
    struct Token6 {}
    struct Token7 {}
    struct Token8 {}
    struct Token9 {}

    const MAX_TOKENS: u64 = 10;
    const E_MAX_TOKENS_REACHED: u64 = 1;

    public entry fun deploy_token(
        creator: &signer,
        name: String,
        symbol: String,
        decimals: u8,
        initial_supply: u64
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
            deploy_token_0(creator, name, symbol, decimals, initial_supply, token_record);
        } else if (token_record.current_index == 1) {
            deploy_token_1(creator, name, symbol, decimals, initial_supply, token_record);
        } else if (token_record.current_index == 2) {
            deploy_token_2(creator, name, symbol, decimals, initial_supply, token_record);
        } else if (token_record.current_index == 3) {
            deploy_token_3(creator, name, symbol, decimals, initial_supply, token_record);
        } else if (token_record.current_index == 4) {
            deploy_token_4(creator, name, symbol, decimals, initial_supply, token_record);
        } else if (token_record.current_index == 5) {
            deploy_token_5(creator, name, symbol, decimals, initial_supply, token_record);
        } else if (token_record.current_index == 6) {
            deploy_token_6(creator, name, symbol, decimals, initial_supply, token_record);
        } else if (token_record.current_index == 7) {
            deploy_token_7(creator, name, symbol, decimals, initial_supply, token_record);
        } else if (token_record.current_index == 8) {
            deploy_token_8(creator, name, symbol, decimals, initial_supply, token_record);
        } else if (token_record.current_index == 9) {
            deploy_token_9(creator, name, symbol, decimals, initial_supply, token_record);
        };
    }

    fun deploy_token_0(
        creator: &signer,
        name: String,
        symbol: String,
        decimals: u8,
        initial_supply: u64,
        token_record: &mut TokenRecord
    ) {
        let creator_addr = signer::address_of(creator);
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<Token0>(
            creator, name, symbol, decimals, true
        );
        let coins = coin::mint(initial_supply, &mint_cap);
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
    }

    fun deploy_token_1(
        creator: &signer,
        name: String,
        symbol: String,
        decimals: u8,
        initial_supply: u64,
        token_record: &mut TokenRecord
    ) {
        let creator_addr = signer::address_of(creator);
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<Token1>(
            creator, name, symbol, decimals, true
        );
        let coins = coin::mint(initial_supply, &mint_cap);
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
    }

    fun deploy_token_2(
        creator: &signer,
        name: String,
        symbol: String,
        decimals: u8,
        initial_supply: u64,
        token_record: &mut TokenRecord
    ) {
        let creator_addr = signer::address_of(creator);
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<Token2>(
            creator, name, symbol, decimals, true
        );
        let coins = coin::mint(initial_supply, &mint_cap);
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
    }

    fun deploy_token_3(
        creator: &signer,
        name: String,
        symbol: String,
        decimals: u8,
        initial_supply: u64,
        token_record: &mut TokenRecord
    ) {
        let creator_addr = signer::address_of(creator);
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<Token3>(
            creator, name, symbol, decimals, true
        );
        let coins = coin::mint(initial_supply, &mint_cap);
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
    }

    fun deploy_token_4(
        creator: &signer,
        name: String,
        symbol: String,
        decimals: u8,
        initial_supply: u64,
        token_record: &mut TokenRecord
    ) {
        let creator_addr = signer::address_of(creator);
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<Token4>(
            creator, name, symbol, decimals, true
        );
        let coins = coin::mint(initial_supply, &mint_cap);
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
    }

    fun deploy_token_5(
        creator: &signer,
        name: String,
        symbol: String,
        decimals: u8,
        initial_supply: u64,
        token_record: &mut TokenRecord
    ) {
        let creator_addr = signer::address_of(creator);
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<Token5>(
            creator, name, symbol, decimals, true
        );
        let coins = coin::mint(initial_supply, &mint_cap);
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
    }

    fun deploy_token_6(
        creator: &signer,
        name: String,
        symbol: String,
        decimals: u8,
        initial_supply: u64,
        token_record: &mut TokenRecord
    ) {
        let creator_addr = signer::address_of(creator);
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<Token6>(
            creator, name, symbol, decimals, true
        );
        let coins = coin::mint(initial_supply, &mint_cap);
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
    }

    fun deploy_token_7(
        creator: &signer,
        name: String,
        symbol: String,
        decimals: u8,
        initial_supply: u64,
        token_record: &mut TokenRecord
    ) {
        let creator_addr = signer::address_of(creator);
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<Token7>(
            creator, name, symbol, decimals, true
        );
        let coins = coin::mint(initial_supply, &mint_cap);
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
    }

    fun deploy_token_8(
        creator: &signer,
        name: String,
        symbol: String,
        decimals: u8,
        initial_supply: u64,
        token_record: &mut TokenRecord
    ) {
        let creator_addr = signer::address_of(creator);
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<Token8>(
            creator, name, symbol, decimals, true
        );
        let coins = coin::mint(initial_supply, &mint_cap);
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
    }

    fun deploy_token_9(
        creator: &signer,
        name: String,
        symbol: String,
        decimals: u8,
        initial_supply: u64,
        token_record: &mut TokenRecord
    ) {
        let creator_addr = signer::address_of(creator);
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<Token9>(
            creator, name, symbol, decimals, true
        );
        let coins = coin::mint(initial_supply, &mint_cap);
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
    }
}