// SPDX-License-Identifier: UNLICENSED

// Usage: source .env && forge script ./script/Deploy.s.sol --rpc-url=$SEPOLIA_RPC_URL --broadcast --etherscan-api-key=$ETHERSCAN_API_KEY --verify

pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import { WrappedVault } from "../src/WrappedVault.sol";
import { WrappedVaultFactory } from "../src/WrappedVaultFactory.sol";
import { Points } from "../src/Points.sol";
import { PointsFactory } from "../src/PointsFactory.sol";
import { VaultMarketHub } from "../src/VaultMarketHub.sol";
import { RecipeMarketHub } from "../src/RecipeMarketHub.sol";
import { WeirollWallet } from "../src/WeirollWallet.sol";

import { MockERC20 } from "test/mocks/MockERC20.sol";
import { MockERC4626 } from "test/mocks/MockERC4626.sol";

contract Deploy is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("HL_OWNER_PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        vm.startBroadcast(deployerPrivateKey);

        RecipeMarketHub recipeMarketHub = RecipeMarketHub(0x6aF057B1c423d108ab710d6f4e3E46f3536787fd);

        console.log(recipeMarketHub.protocolFee());
        console.log(recipeMarketHub.minimumFrontendFee());
        recipeMarketHub.setMinimumFrontendFee(0);
        recipeMarketHub.setProtocolFee(0.04e18);
        console.log(recipeMarketHub.protocolFee());
        console.log(recipeMarketHub.minimumFrontendFee());

        vm.stopBroadcast();
    }
}
