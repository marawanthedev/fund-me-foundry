// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import {Test, console2, StdStyle} from "../src/Test.sol";

contract StdStyleTest is Test {
    function test_StyleColor() public pure {
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }

    function test_StyleFontWeight() public pure {
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }

    function test_StyleCombined() public pure {
        
        
        
        
        
    }

    function test_StyleCustom() public pure {
        
        
    }

    function h1(string memory a) private pure returns (string memory) {
        return StdStyle.cyan(StdStyle.inverse(StdStyle.bold(a)));
    }

    function h2(string memory a) private pure returns (string memory) {
        return StdStyle.magenta(StdStyle.bold(StdStyle.underline(a)));
    }
}
