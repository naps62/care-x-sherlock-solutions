interface Item {
  setup: string;
  challenge: string;
  finalizeValue?: string;
  deployValue?: string;
  status?: string;
}

const challenges: Record<string, Item> = {
  "0xmoostorm": {
    setup: "0x5e40D0d98126323b81246008d386a93BA091704f",
    challenge: "0xE442a00a4587677c945598e19DF41822e851c1DE",
    status: "ready",
  },
  "0xNazgul": {
    setup: "0xd80960575d177A09FEb8497dBaE9F6583fcFe297",
    challenge: "0x75b665c3695293659949c18719d046089F423834",
  },
  agusduha: {
    setup: "0x459D9C80482c541deC1Aa491209EF598BF7c9344",
    challenge: "0x4B8df63820cD31D063a160e1C40f8583227591cB",
  },
  bahurum: {
    setup: "0xABF1f66a9fb48F3f5b75C8A83FB5854A9d906343",
    challenge: "0x68C3CA33c766cd60E4Af98D697EBd541B4DA7968",
    status: "test",
  },
  band0x: {
    setup: "0x46C9489797c5647F850dD3A5bcB13C240bcd383A",
    challenge: "0xD2034a50C5Adc8A190D4f8c8EE18643Ab8A0ff05",
    finalizeValue: "0.001",
    status: "ready",
  },
  Baraa42: {
    setup: "0xFfb20eF6668F8160934FD84b60F3DeD127F787Aa",
    challenge: "0x31448618e0C48c6Bcb2A729709DDF51F1cA0c628",
  },
  BowTiedPickle: {
    setup: "0xfF2c41d306098Ce69316C781137EaF05FABDFF6b",
    challenge: "0xF8e8370A8d0a840DB47B2d52BEe5C549aD04809a",
    finalizeValue: "0.0001",
    status: "ready",
  },
  chaboo: {
    setup: "0x0a73CA730FaF56126487196a4B7E10B2A9B3df67",
    challenge: "0x014D1921A1237b6e8fF3FA960333329667F7e242",
    status: "ready",
  },
  ebaizel: {
    setup: "0x5364B5A9e489b495CaAE4722e9706C817Cf54433",
    challenge: "0x784B7A7A25ED38EF830AEFe7985c64f3AdF08346",
    status: "pending",
  },
  hack3r0m: {
    setup: "0xA083913ed673b23dC5FB921b3909021CacFD794C",
    challenge: "0x16051547CbaD42bBec882A7E9e6091796d0D1f50",
    finalizeValue: "1",
    status: "ready",
  },
  iflp: {
    setup: "0x38B500E61267Ee672c823bE3a8fA559236Bd1FD3",
    challenge: "0x070Cd04E0Ab2bF1E10411f7aB1b0972164F72879",
    deployValue: "1",
    status: "ready",
  },
  johngish: {
    setup: "0x427255B0e21A7f0D809c7cE854569A10df44378d",
    challenge: "0x2Dec5971b627485A50af67a921C6ADB6CC3ffCe4",
    finalizeValue: "0.0001",
    status: "ready",
  },
  JustDravee: {
    setup: "0x1f5c09a7d6a9B30b43DDDAABD384425DEe0ADe91",
    challenge: "0xc7e13b9c94Eb3902Fa272E83Bb4D19392d09eF4d",
    deployValue: "1",
    status: "ready",
  },
  KahanMajmudar: { setup: "0x0", challenge: "0x0" },
  kankan0: {
    setup: "0x9e6C0511d07695420A0B57003d6e8c133Cd0185d",
    challenge: "0x7e18A61fd65F5E5Cf693257235a0A1F360aBE7d8",
    finalizeValue: "10",
    status: "ready",
  },
  kuldeep23907: {
    setup: "0x0ABBC49482097b530516d385B4dD183b59073f1C",
    challenge: "0x7DC33b58B3258a745C0ADbfC46d8A4B543254f24",
    deployValue: "1",
    finalizeValue: "1",
    status: "pending",
  },
  lucyoa: {
    setup: "0xe95dF719Fc223CD8E57bA9bAAb8E86bEDF3e5d69",
    challenge: "0x4C9bf01acEA21DDC7Ca25d49d301B8bDd63c1966",
    status: "ready",
  },
  luksgrin: {
    setup: "0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F",
    challenge: "0x137A5B4bB53A62BD1Db46e563b89D1884afaC0Ac",
    deployValue: "1",
    finalizeValue: "100",
    status: "pending",
  },
  mhchia: {
    setup: "0x6c06959586640De3BcdE69BDcEbF2efDa5d3983B",
    challenge: "0xC2c83168E3bf85A5DEabF25f9f9873085C201C79",
    finalizeValue: "1",
    status: "ready",
  },
  naps62: {
    setup: "0x4742FD1862E94dc74AeD62A96B6374E68e658f80",
    challenge: "0xA1BCb047E9dc4aCcB36c14288239f9283DF3E68e",
    status: "ready",
  },
  PeterisPrieditis: {
    setup: "0x64A9fcaD8D299aF9B1a96dA17458c0b3D876b687",
    challenge: "0x94f12A6fb7D9B0cBBc43CdDC6A4827649f757c72",
    status: "pending",
  },
  plotchy: {
    setup: "0x869a2D3856BE26cfE77cC7Cb6579219d13373Bc9",
    challenge: "0xebb997D2FabE73df8cF88Ab28b82B70741592525",
    status: "pending",
  },
  RomiRand: {
    setup: "0x85CCd0c58Fe07DC6716f1EfCcAba0164b97ae66B",
    challenge: "0x3dc21F58F3b77aDD4AD5D40992C0B431bdFFc6B8",
    status: "pending",
  },
  saianmk: {
    setup: "0xbFB2C43021629C87b83C97F1FAC8D5f6b1078593",
    challenge: "0xB5193e99607e7e63B49ACC48fCe0AC7A3676e4F6",
    status: "pending",
  },
  sidduHERE: {
    setup: "0x76BB80b4F1bA62eD2665f537f605C3593daCc458",
    challenge: "0x43c3E684cfCD27083f7156E7d883FC7e449e1c59",
    finalizeValue: "1",
    status: "ready",
  },
  smbsp: {
    setup: "0x838Ed804d95044516C16473C91388AE195da0B76",
    challenge: "0xf8cd9B34e1B526Fef4D0eb2cA595D3D349F2301a",
    finalizeValue: "1",
    status: "ready",
  },
  tnero: {
    setup: "0x34e5EC7DA55039f332949a6d7dB506cD94594E12",
    challenge: "0x2488764643d43f974b3819dc14400543B3DF9904",
    deployValue: "1",
    finalizeValue: "10",
    status: "pending",
  },
  teryanarmen: {
    setup: "0xAD392F2a981bDE60B43eC988a30ce2aE2d755eD2",
    challenge: "0x8720D38BbC9212B8fD202BCcda07cff32b6F7920",
    status: "pending",
  },
  Thro77le: {
    setup: "0xBF3e5530aB7Dcba712E3A7fA99463d46eb6a0c8e",
    challenge: "0xd9C72eD9DdeF04D0Ab88aE2403C383Ffbd11a71c",
    finalizeValue: "1",
    status: "pending",
  },
  tqtsar: {
    setup: "0x0dCb022a9927613f1B4B23F4F893515BA196c5c5",
    challenge: "0x44898e95E81600e7aD0a85F7e1A5daA987BC1365",
    status: "pending",
  },
  wuwe1: {
    setup: "0xB1F9187d9FFCd22fE2c26FeF3E8b8F90C31Ae885",
    challenge: "0x34D471c17D0fb5eF3029Bda742AE4bed05ff5eB4",
  },
  ych18: {
    setup: "0x40D1e6Fa69957f4c66461b8c8AB60108265F52b2",
    challenge: "0x482b62c99e9ee97126b8a56828f105e07904fd03",
    finalizeValue: "2",
    status: "ready",
  },
};

export default challenges;
