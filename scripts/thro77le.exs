defmodule Foo do
  @deployer "FD4f30C20dA65a37fd74d55B257442a08469e6A6" |> Base.decode16!(case: :mixed);
  @salt "0000000000000000000000000000000000000000000000000000000000022ca3" |> Base.decode16!(case: :mixed)
  @code "608060405234801561001057600080fd5b5061015d806100206000396000f3fe608060405234801561001057600080fd5b50600436106100365760003560e01c806306fdde031461003b5780637872ab4914610059575b600080fd5b61004361009d565b6040518082815260200191505060405180910390f35b61009b6004803603602081101561006f57600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff1690602001909291905050506100c5565b005b60007f736d617278000000000000000000000000000000000000000000000000000000905090565b8073ffffffffffffffffffffffffffffffffffffffff1663380c7a676040518163ffffffff1660e01b8152600401600060405180830381600087803b15801561010d57600080fd5b505af1158015610121573d6000803e3d6000fd5b505050505056fea265627a7a72315820fb2fc7a07f0eebf799c680bb1526641d2d905c19393adf340a04e48c9b527de964736f6c634300050c0032" |> Base.decode16!(case: :mixed)
  @codehash ExKeccak.hash_256(@code)

  def i_to_salt(i) do
    i
    |> Integer.to_string(16)
    |> String.pad_leading(64, "0")
    |> Base.decode16!(case: :mixed)
  end

  def get_address(i) do
    salt = i_to_salt(i)

    str = <<255 :: size(8)>> <> @deployer <> salt <> @codehash

    address = ExKeccak.hash_256(str)
    |> Binary.drop(12)
    |> Base.encode16()


    chunks = for <<chunk::size(4)-binary <- address>>, do: chunk

    {i, address}
  end

  def valid?({i, address}) do
    address
    |> String.match?(~r/.{6,}F0B1D/)
  end

  def run do
    (1..1000000)
    |> Flow.from_enumerable()
    |> Flow.map(&get_address/1)
    |> Flow.filter(&valid?/1)
    |> Enum.at(0)
    |> IO.inspect
  end

end

Foo.run()
