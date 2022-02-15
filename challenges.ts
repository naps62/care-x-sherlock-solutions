interface Item {
  setup: string;
  challenge: string;
  status: string;
  finalizeValue?: string;
  deployValue?: string;
}

const values: Record<string, Item> = {
  0: {
    setup: "0x6b24634B517a63Ed0fa2a39977286e13e7E35E25",
    challenge: "0x338e89eeE89fCb4937Fe401214Cee5C538823EaF",
    status: "",
  },
  1: {
    setup: "0x1b17Fe87bD49e6ef872b4Fd46fB8280811D795A8",
    challenge: "0xe374e8882533B844f33B1425C7F60f3689e3698B",
    status: "NV",
  },
  2: {
    setup: "0x5606dc3Ebf7C4e88a1bCD708A9c7b4d139bBCCae",
    challenge: "0xe7b2F79b5cd266f3eC3b8cE241c8207d970A6aa1",
    status: "NV",
  },
  3: {
    setup: "0x6b24634B517a63Ed0fa2a39977286e13e7E35E25",
    challenge: "0xC938077C5334Ab2969eCCF6319A73ab363bA448e",
    status: "",
  },
  4: {
    setup: "0xc463cB02541bFF05BBD45154F984Be1dEe958d59",
    challenge: "0x784fDb22d7D3ba13bF7a2ae606CD1F62f8C7765e",
    status: "",
  },
  5: {
    setup: "0xF06c4D42dBD9A51835b62e8Be43E95Ae6749fE21",
    challenge: "0xc0B42191749A606509804eBCc6a08726cb14688E",
    status: "done",
  },
  6: {
    setup: "0x838Ed804d95044516C16473C91388AE195da0B76",
    challenge: "0xf8cd9B34e1B526Fef4D0eb2cA595D3D349F2301a",
    status: "",
  },
  7: {
    setup: "0x17f59F276b807FA9DB93B90225FC45b51a01E262",
    challenge: "0x9979127DE6660543dDabF1d00f97E0d1AACA2a21",
    status: "",
  },
  8: {
    setup: "0x590525f8362BdDb1dDA388077310EBebA671F43d",
    challenge: "0xD264B21C519f403Fb76039f121cFf98F3B29e6B5",
    status: "",
  },
  9: {
    setup: "0xFfb20eF6668F8160934FD84b60F3DeD127F787Aa",
    challenge: "0x664152c40e3bA69F3791dD07EdB6dbF4444ccF23",
    status: "",
  },
  10: {
    setup: "0xBA18F8D2Ffc20801950Ae978EE2792eAFfbCc2cb",
    challenge: "0x382525B7e8B40Ff9596530216A885C52c511e913",
    status: "",
  },
  11: {
    setup: "0x34e5EC7DA55039f332949a6d7dB506cD94594E12",
    challenge: "0x2488764643d43f974b3819dc14400543B3DF9904",
    status: "",
  },
  12: {
    setup: "0x64A9fcaD8D299aF9B1a96dA17458c0b3D876b687",
    challenge: "0x94f12A6fb7D9B0cBBc43CdDC6A4827649f757c72",
    status: "",
  },
  13: {
    setup: "0xc1dDA4F629ec2c0ec0cD8C8619182f924a53CcD2",
    challenge: "0x412089DA3B6266a6821Cb00475D42FeCE35E110B",
    status: "",
  },
  14: {
    setup: "0x85CCd0c58Fe07DC6716f1EfCcAba0164b97ae66B",
    challenge: "0x3dc21F58F3b77aDD4AD5D40992C0B431bdFFc6B8",
    status: "",
  },
  15: {
    setup: "0xd1e3bdeB9a027e6B98F689001bd7EFeFfcd3d62f",
    challenge: "0x4d0110377e76B8700280BFC51D30708140933b22",
    status: "",
  },
  16: {
    setup: "0x5E74FcF5f0e2BF57Fb86CfEfc49E5F7F9765e276",
    challenge: "0x772dE5258a478Eb9926789f25a1eda0E49A8928f",
    status: "",
  },
  17: {
    setup: "0x459D9C80482c541deC1Aa491209EF598BF7c9344",
    challenge: "0x1020dFFD73141616fa7A931feE757DC9114B79D9",
    status: "",
  },
  18: {
    setup: "0x10b2E01DF73b4214d13E7bCd019Cd8C39DF623eF",
    challenge: "0xB2Ae8CcB32bfa17AD4e1C26d20cbeFfb37364A82",
    status: "",
  },
  19: {
    setup: "0xbFB2C43021629C87b83C97F1FAC8D5f6b1078593",
    challenge: "0xB5193e99607e7e63B49ACC48fCe0AC7A3676e4F6",
    status: "",
  },
  20: {
    setup: "0x3137961B2221ab001DF209B8CAEcaa3Bfe6b965A",
    challenge: "0x2440dC5B2251b6af30D5E4A5029B26d8B4f8097D",
    status: "",
  },
  21: {
    setup: "0x4742FD1862E94dc74AeD62A96B6374E68e658f80",
    challenge: "0xA1BCb047E9dc4aCcB36c14288239f9283DF3E68e",
    status: "",
  },
  22: {
    setup: "0xABF1f66a9fb48F3f5b75C8A83FB5854A9d906343",
    challenge: "0x68C3CA33c766cd60E4Af98D697EBd541B4DA7968",
    status: "",
  },
  23: {
    setup: "0x0dCb022a9927613f1B4B23F4F893515BA196c5c5",
    challenge: "0x44898e95E81600e7aD0a85F7e1A5daA987BC1365",
    status: "",
  },
  24: {
    setup: "0x0DA6D049020db21A19D387eEA846fd057c2AcE6F",
    challenge: "0x9eA47E24f3e8b837A7c0A7D6bC3a3Ae946B3bcb2",
    status: "",
  },
  25: {
    setup: "0x26d461a585F3bd19317ab0fD171c11acf8218129",
    challenge: "0x981a00D3DF4fF2e5dE8c25940b14449f2a5dCaB3",
    status: "",
  },
  26: {
    setup: "0xe95dF719Fc223CD8E57bA9bAAb8E86bEDF3e5d69",
    challenge: "0x4C9bf01acEA21DDC7Ca25d49d301B8bDd63c1966",
    status: "",
  },
  27: {
    setup: "0xEA24831C86c29A5dbfc54B8B1D4FEad35A30d490",
    challenge: "0xdA4cbb8eEfbfEfED3ddbeEfa4868732812830B06",
    status: "",
  },
  28: {
    setup: "0xd80960575d177A09FEb8497dBaE9F6583fcFe297",
    challenge: "0x75b665c3695293659949c18719d046089F423834",
    status: "",
  },
  29: {
    setup: "0x1f5c09a7d6a9B30b43DDDAABD384425DEe0ADe91",
    challenge: "0xc7e13b9c94Eb3902Fa272E83Bb4D19392d09eF4d",
    status: "",
  },
  30: {
    setup: "0xfa6B1DC84730906417F2160d58F0d56F78F9fA88",
    challenge: "0x03145Dc90649Ba9d3B73111Cb658530222fdb556",
    status: "",
  },
  31: {
    setup: "0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F",
    challenge: "0x137A5B4bB53A62BD1Db46e563b89D1884afaC0Ac",
    status: "",
  },
  32: {
    setup: "0xa310e233018F11A0a0DE07C7d663F241F30e1be7",
    challenge: "0x3C046BCCF5089c02915D8AA79742818C0B478179",
    status: "",
  },
  33: {
    setup: "0x324e6AD3b537c2783b917a3c6947B07A713271a8",
    challenge: "0xeBff2d11cCfAa29AB53A636669d55D197e022388",
    status: "",
  },
  34: {
    setup: "0xB1F9187d9FFCd22fE2c26FeF3E8b8F90C31Ae885",
    challenge: "0xc0E7beD54707b176A540C0b30bCB50c86e55b553",
    status: "",
  },
  35: {
    setup: "0x4b24A682Bd789fb3E5AADb091971be61BEE60635",
    challenge: "0x863aB24261cCAF4533A35f14eCb5687a3BE73599",
    status: "NV",
  },
  36: {
    setup: "0x93eF637aC7E96B2431E28c8C71C8A17B9c5CC228",
    challenge: "0x92eBe963B7385ffce64429cb0A164d47CDB4C8f1",
    status: "NV",
  },
  37: {
    setup: "0x943bF115239b47eB98F47eb6497337c68F00fD59",
    challenge: "0xE1A7E30a10b0C319d2A1808D1AC9309B1e8e22EB",
    status: "NV",
  },
  38: {
    setup: "0x76BB80b4F1bA62eD2665f537f605C3593daCc458",
    challenge: "0x43c3E684cfCD27083f7156E7d883FC7e449e1c59",
    status: "done",
  },
  39: {
    setup: "0x6c06959586640De3BcdE69BDcEbF2efDa5d3983B",
    challenge: "0xC2c83168E3bf85A5DEabF25f9f9873085C201C79",
    status: "NV",
  },
  40: {
    setup: "0xAD392F2a981bDE60B43eC988a30ce2aE2d755eD2",
    challenge: "0x8720D38BbC9212B8fD202BCcda07cff32b6F7920",
    status: "NV",
  },
  41: {
    setup: "0x869a2D3856BE26cfE77cC7Cb6579219d13373Bc9",
    challenge: "0xebb997D2FabE73df8cF88Ab28b82B70741592525",
    status: "",
  },
  42: {
    setup: "0x38B500E61267Ee672c823bE3a8fA559236Bd1FD3",
    challenge: "0x070Cd04E0Ab2bF1E10411f7aB1b0972164F72879",
    status: "done",
  },
};

export default values;
