// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import {Base64} from "./libraries/Base64.sol";

import {StringUtils} from "./libraries/StringUtils.sol";

import "hardhat/console.sol";

contract Domains is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address public owner;

    string public tld;

    mapping(string => address) public domains;
    mapping(string => string) public records;
    mapping(uint256 => string) public names;

    ///ypu are not the owner
    error onlyOwner();

    ///transaction failed
    error failed();

    ///domain is already register
    error alreadyRegister();

    ///Domain length should be >=3 and <=10
    error invalidDomain();

    /// domain name is not authorise
    error Unauthorise();

    string svgPartOne =
        '<svg xmlns="http://www.w3.org/2000/svg" width="270" height="270" fill="none"><path fill="url(#B)" d="M0 0h270v270H0z"/><defs><filter id="A" color-interpolation-filters="sRGB" filterUnits="userSpaceOnUse" height="270" width="270"><feDropShadow dx="0" dy="1" stdDeviation="2" flood-opacity=".225" width="200%" height="200%"/></filter></defs><path d="M72.863 42.949c-.668-.387-1.426-.59-2.197-.59s-1.529.204-2.197.59l-10.081 6.032-6.85 3.934-10.081 6.032c-.668.387-1.426.59-2.197.59s-1.529-.204-2.197-.59l-8.013-4.721a4.52 4.52 0 0 1-1.589-1.616c-.384-.665-.594-1.418-.608-2.187v-9.31c-.013-.775.185-1.538.572-2.208a4.25 4.25 0 0 1 1.625-1.595l7.884-4.59c.668-.387 1.426-.59 2.197-.59s1.529.204 2.197.59l7.884 4.59a4.52 4.52 0 0 1 1.589 1.616c.384.665.594 1.418.608 2.187v6.032l6.85-4.065v-6.032c.013-.775-.185-1.538-.572-2.208a4.25 4.25 0 0 0-1.625-1.595L41.456 24.59c-.668-.387-1.426-.59-2.197-.59s-1.529.204-2.197.59l-14.864 8.655a4.25 4.25 0 0 0-1.625 1.595c-.387.67-.585 1.434-.572 2.208v17.441c-.013.775.185 1.538.572 2.208a4.25 4.25 0 0 0 1.625 1.595l14.864 8.655c.668.387 1.426.59 2.197.59s1.529-.204 2.197-.59l10.081-5.901 6.85-4.065 10.081-5.901c.668-.387 1.426-.59 2.197-.59s1.529.204 2.197.59l7.884 4.59a4.52 4.52 0 0 1 1.589 1.616c.384.665.594 1.418.608 2.187v9.311c.013.775-.185 1.538-.572 2.208a4.25 4.25 0 0 1-1.625 1.595l-7.884 4.721c-.668.387-1.426.59-2.197.59s-1.529-.204-2.197-.59l-7.884-4.59a4.52 4.52 0 0 1-1.589-1.616c-.385-.665-.594-1.418-.608-2.187v-6.032l-6.85 4.065v6.032c-.013.775.185 1.538.572 2.208a4.25 4.25 0 0 0 1.625 1.595l14.864 8.655c.668.387 1.426.59 2.197.59s1.529-.204 2.197-.59l14.864-8.655c.657-.394 1.204-.95 1.589-1.616s.594-1.418.609-2.187V55.538c.013-.775-.185-1.538-.572-2.208a4.25 4.25 0 0 0-1.625-1.595l-14.993-8.786z" fill="#fff"/><defs><linearGradient id="B" x1="0" y1="0" x2="270" y2="270" gradientUnits="userSpaceOnUse"><stop stop-color="#cb5eee"/><stop offset="1" stop-color="#0cd7e4" stop-opacity=".99"/></linearGradient></defs><text x="32.5" y="231" font-size="27" fill="#fff" filter="url(#A)" font-family="Plus Jakarta Sans,DejaVu Sans,Noto Color Emoji,Apple Color Emoji,sans-serif" font-weight="bold">';
    string svgPartTwo = "</text></svg>";

    constructor(string memory _tld)
        payable
        ERC721("Ninja Name Service", "NNS")
    {
        tld = _tld;
        console.log("%s name service deployed", _tld);
        owner = msg.sender;
    }

    function getAllNames() public view returns (string[] memory) {
        console.log("Getting all names from contract");
        string[] memory allNames = new string[](_tokenIds.current());

        for (uint256 i = 0; i < _tokenIds.current(); i++) {
            allNames[i] = names[i];
            console.log("Names for the token id %d is %s", i, allNames[i]);
        }
        return allNames;
    }

    function valid(string calldata name) public pure returns (bool) {
        return StringUtils.strlen(name) >= 3 && StringUtils.strlen(name) <= 10;
    }

    function withdraw() public {
        if (msg.sender != owner) {
            revert onlyOwner();
        }

        uint256 Amount = address(this).balance;

        (bool sent, ) = msg.sender.call{value: Amount}("");

        if (!sent) {
            revert failed();
        }
    }

    function setRecord(string calldata name, string calldata record) public {
        if (domains[name] != msg.sender) {
            revert Unauthorise();
        }

        records[name] = record;
    }

    // function price(string calldata name) public pure returns (uint256) {
    //     uint256 len = StringUtils.strlen(name);
    //     require(len > 0);
    //     if (len == 3) {
    //         return 5 * 10**17;
    //     } else if (len == 4) {
    //         return 3 * 10**17;
    //     } else {
    //         return 1 * 10**14;
    //     }
    // }

    function price(string calldata name) public pure returns (uint256) {
        uint256 len = StringUtils.strlen(name);
        require(len > 0);
        if (len == 3) {
            return 5 * 10**17;
        } else if (len == 4) {
            return 3 * 10**17;
        } else {
            return 1 ^10**14 ;
        }
    }

    function register(string calldata name) public payable {
        if (domains[name] != address(0)) {
            revert alreadyRegister();
        }
        if (!valid(name)) {
            revert();
        }

        uint256 _price = price(name);
        console.log("Price :",_price);

        // Check if enough Matic was paid in the transaction
        require(msg.value >= _price, "Not enough Matic paid");

        string memory _name = string(abi.encodePacked(name, ".", tld));

        string memory finalSVG = string(
            abi.encodePacked(svgPartOne, _name, svgPartTwo)
        );

        uint256 newRecordId = _tokenIds.current();
        uint256 length = StringUtils.strlen(name);
        string memory strlen = Strings.toString(length);

        console.log(
            "Registering %s.%s on the tokenId %d",
            name,
            tld,
            newRecordId
        );

        string memory json = Base64.encode(
            abi.encodePacked(
                '{"name": "',
                _name,
                '", "description": "A domain on the Ninja name service", "image": "data:image/svg+xml;base64,',
                Base64.encode(bytes(finalSVG)),
                '","length":"',
                strlen,
                '"}'
            )
        );
        string memory finaltokenURI = string(
            abi.encodePacked("data:application/json;base64,", json)
        );
        console.log("____________________________________________");
        console.log("Final token URI :", finaltokenURI);
        console.log("______________________________________________");
        _safeMint(msg.sender, newRecordId);
        _setTokenURI(newRecordId, finaltokenURI);

        domains[name] = msg.sender;
        _tokenIds.increment();
        console.log("%s has registered a domain!", msg.sender);
        names[newRecordId] = name;
    }

    function getAddress(string calldata name) public view returns (address) {
        return domains[name];
    }
}
