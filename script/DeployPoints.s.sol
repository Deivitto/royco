// SPDX-License-Identifier: UNLICENSED

// Usage: source .env && forge script ./script/Deploy.s.sol --rpc-url=$SEPOLIA_RPC_URL --broadcast --etherscan-api-key=$ETHERSCAN_API_KEY --verify

pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import { Points } from "../src/Points.sol";
import { PointsFactory } from "../src/PointsFactory.sol";

contract Deploy is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        vm.startBroadcast(deployerPrivateKey);

        PointsFactory pointsFactory = PointsFactory(0xC0bd79DEA95c1E1C474CE29d489E81dFFcf15d49);

        string[] memory names = new string[](7);
        names[0] = "Harmonix Points";
        names[1] = "TimeSwap Points";
        names[2] = "Hyperlend Points";
        names[3] = "HyperSwap Points";
        names[4] = "HypurrFi Points";
        names[5] = "Silhouette Points";
        names[6] = "Dahlia Points";

        string[] memory symbols = new string[](7);
        symbols[0] = "HXP";
        symbols[1] = "TSP";
        symbols[2] = "HLNDP";
        symbols[3] = "HSWPP";
        symbols[4] = "PRRP";
        symbols[5] = "SP";
        symbols[6] = "DP";

        address[] memory ips = new address[](7);
        ips[0] = 0xc7E4DA817B96E52d597220bc4bD9Fbd71333158b;
        ips[1] = 0x69e8BcbCAB1E791Ed1B352e4350c32C2eab667d0;
        ips[2] = 0x0E61A8fb14f6AC999646212D30b2192cd02080Dd;
        ips[3] = 0x6ec515f8e17B03a49C1285c26944FAA056225770;
        ips[4] = address(0);
        ips[5] = 0xDdEf5731bfc6cf83355351349e14376DAB7D1BDC;
        ips[6] = address(0);

        for (uint256 i = 2; i < names.length; ++i) {
            Points points = pointsFactory.createPointsProgram(names[i], symbols[i], 18, 0x77777Cc68b333a2256B436D675E8D257699Aa667);
            console.log(points.name(), points.symbol(), "deployed at:");
            console.log(address(points));

            if (ips[i] != address(0)) {
                points.addAllowedIP(ips[i]);
                console.log(points.name(), "added allowed IP:");
                console.log(ips[i]);

                points.transferOwnership(ips[i]);
                console.log(points.name(), "transferred ownership to:");
                console.log(ips[i]);
            }
            console.log("\n");
        }

        vm.stopBroadcast();
    }
}
