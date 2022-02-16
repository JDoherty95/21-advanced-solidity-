pragma solidity ^0.5.0;

import "./KaseiCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

// @TODO: Inherit the crowdsale contracts
contract KaseiCoinCrowdSale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {

    constructor(
        uint rate,
        uint openingtime,
        uint closingtime,
        uint goal,
        address payable wallet, 
        KaseiCoin token
        
    )
        MintedCrowdsale()
        RefundableCrowdsale(goal)
        TimedCrowdsale(openingtime,closingtime)
        public Crowdsale(rate,wallet,token)
       
    {
        // constructor can stay empty
    }
}


contract KaseiCoinCrowdSaleDeployer {

    address public 'kaseo_token_address';
    address public 'kasei_crowdsale_address';

    constructor(
        string memory name, 
        string memory symbol, 
        address payable wallet 
        
    )
        public
    {
        KaseiCoin token = new KaseiCoin(name, symbol, 0);
        token_address = address(token);
        
        // @TODO: create the KaseiCrowdCoinSale and tell it about the token, set the goal, and set the open and close times to now and now + 24 weeks.
        uint opening_time = now;
        uint closing_time = now + 24 weeks;

        KaseiCrowdCoinSale token_sale = new KaseiCoinSale(1,wallet,token,opening_time,closing_time,300);
        token_sale_address = address(token_sale);
        
        
        // make the KaseiCoinSale contract a minter, then have the KaseiCoinSaleDeployer renounce its minter role
        token.addMinter(token_sale_address);
        token.renounceMinter();
    }
}



