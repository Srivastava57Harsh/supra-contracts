module exampleAddress::token_factory_smoke {
    use std::string::{Self, String};  // Added string module import
    use std::signer;
    use std::vector;
    use supra_framework::coin::{Self, BurnCapability, FreezeCapability, MintCapability};
    
    struct TokenRecord has key {
        deployed_tokens: vector<TokenInfo>
    }

    struct TokenInfo has store, drop, copy {
        token_address: address,
        name: String,
        symbol: String,
        creator: address
    }

    // Each token gets its own unique struct type
    struct USDT {} 
    struct USDC {}
    struct DAI {}
    struct WETH {}
    struct WBTC {}

    public entry fun initialize(admin: &signer) {
        move_to(admin, TokenRecord {
            deployed_tokens: vector::empty()
        });
    }

    // Deploy specific token types
    public entry fun deploy_usdt(creator: &signer, decimals: u8) acquires TokenRecord {
        deploy_token<USDT>(creator, string::utf8(b"Tether USD"), string::utf8(b"USDT"), decimals);
    }

    public entry fun deploy_usdc(creator: &signer, decimals: u8) acquires TokenRecord {
        deploy_token<USDC>(creator, string::utf8(b"USD Coin"), string::utf8(b"USDC"), decimals);
    }

    public entry fun deploy_dai(creator: &signer, decimals: u8) acquires TokenRecord {
        deploy_token<DAI>(creator, string::utf8(b"Dai Stablecoin"), string::utf8(b"DAI"), decimals);
    }

    fun deploy_token<CoinType>(
        creator: &signer,
        name: String,
        symbol: String,
        decimals: u8,
    ) acquires TokenRecord {
        let creator_addr = signer::address_of(creator);

        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<CoinType>(
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
}