module exampleAddress::token_factory_master {
    use std::string::String;
    use std::signer;
    use std::vector;
    use supra_framework::coin::{Self, MintCapability};

    struct TokenRecord has key {
        deployed_tokens: vector<TokenInfo>,
        current_index: u64
    }

    struct Token0MintCap has key { cap: MintCapability<Token0> }
    struct Token1MintCap has key { cap: MintCapability<Token1> }
    struct Token2MintCap has key { cap: MintCapability<Token2> }
    struct Token3MintCap has key { cap: MintCapability<Token3> }
    struct Token4MintCap has key { cap: MintCapability<Token4> }
    struct Token5MintCap has key { cap: MintCapability<Token5> }
    struct Token6MintCap has key { cap: MintCapability<Token6> }
    struct Token7MintCap has key { cap: MintCapability<Token7> }
    struct Token8MintCap has key { cap: MintCapability<Token8> }
    struct Token9MintCap has key { cap: MintCapability<Token9> }

    struct TokenInfo has store, drop, copy {
        token_address: address,
        name: String,
        symbol: String,
        creator: address
    }

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
        
        // Register coin store first
        if (!coin::is_account_registered<Token0>(creator_addr)) {
            coin::register<Token0>(creator);
        };

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
        move_to(creator, Token0MintCap { cap: mint_cap });

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
        
        if (!coin::is_account_registered<Token1>(creator_addr)) {
            coin::register<Token1>(creator);
        };

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
        move_to(creator, Token1MintCap { cap: mint_cap });

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
        
        if (!coin::is_account_registered<Token2>(creator_addr)) {
            coin::register<Token2>(creator);
        };

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
        move_to(creator, Token2MintCap { cap: mint_cap });

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
        
        if (!coin::is_account_registered<Token3>(creator_addr)) {
            coin::register<Token3>(creator);
        };

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
        move_to(creator, Token3MintCap { cap: mint_cap });

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
        
        if (!coin::is_account_registered<Token4>(creator_addr)) {
            coin::register<Token4>(creator);
        };

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
        move_to(creator, Token4MintCap { cap: mint_cap });

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
        
        if (!coin::is_account_registered<Token5>(creator_addr)) {
            coin::register<Token5>(creator);
        };

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
        move_to(creator, Token5MintCap { cap: mint_cap });

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
        
        if (!coin::is_account_registered<Token6>(creator_addr)) {
            coin::register<Token6>(creator);
        };

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
        move_to(creator, Token6MintCap { cap: mint_cap });

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
        
        if (!coin::is_account_registered<Token7>(creator_addr)) {
            coin::register<Token7>(creator);
        };

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
        move_to(creator, Token7MintCap { cap: mint_cap });

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
        
        if (!coin::is_account_registered<Token8>(creator_addr)) {
            coin::register<Token8>(creator);
        };

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
        move_to(creator, Token8MintCap { cap: mint_cap });

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
        
        if (!coin::is_account_registered<Token9>(creator_addr)) {
            coin::register<Token9>(creator);
        };

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
        move_to(creator, Token9MintCap { cap: mint_cap });

        coin::destroy_burn_cap(burn_cap);
        coin::destroy_freeze_cap(freeze_cap);
    }
}