use Bitwise

bytes = [0x6e, 0x3c, 0x5b, 0x0f, 0x72, 0x2c, 0x43, 0x0e, 0x6d, 0x32, 0x4c, 0x0d, 0x6f, 0x67, 0x17, 0x3d, 0x4b, 0x15, 0x65, 0x34, 0x59, 0x15, 0x75, 0x35, 0x04, 0x21, 0x1f]


IO.puts("texting 0x26")
x=0x48
x = bxor(x, 0x6e)
x = bxor(x, x>>>4)
x = bxor(x, x>>>3)
x = bxor(x, x>>>2)
x = bxor(x, x>>>1)
IO.puts(x)

defmodule Foo do
  def bruteforce(x, prev) do
    IO.puts("bruteforcing #{Integer.to_string(x, 16)} (with prev=#{Integer.to_string(prev, 16)})")
    f=0..255
    |> Enum.to_list()
    |> Enum.find(fn i ->
      i = if (prev != -1) do
        bxor(i, prev)
      else
        i
      end
      i = bxor(i, i >>> 4)
      i = bxor(i, i >>> 3)
      i = bxor(i, i >>> 2)
      i = bxor(i, i >>> 1)

      i == x
    end)

    IO.puts("found #{Integer.to_string(f, 16)}")
    f
  end

  def test(key) do
    key|>Enum.with_index()
    |>Enum.map(fn {x, i}->
      x=if (i > 0) do
        bxor(x, Enum.at(key, i-1))
      else
        x
      end
      x = bxor(x, x>>>4)
      x = bxor(x, x>>>3)
      x = bxor(x, x>>>2)
      x = bxor(x, x>>>1)
      x
    end)
  end
end

x = 0x53
x=bxor(x, x>>>4)
x=bxor(x, x>>>3)
x=bxor(x, x>>>2)
x=bxor(x, x>>>1)
IO.inspect(x)
IO.inspect("encrypted")
IO.puts(bytes)

bytes_reversed = bytes|>Enum.reverse()

solution=
bytes
|> Enum.reverse()
|> Enum.with_index()
|> Enum.map(fn {x, i} -> Foo.bruteforce(x, Enum.at(bytes_reversed, i+1, -1)) end)
|> Enum.reverse()

IO.inspect("solution")
solution
|> Enum.map(fn x -> Integer.to_string(x, 16) <> " " end)
IO.inspect("hex solution")
solution
|> Enum.map(fn x -> Integer.to_string(x, 16) <> " " end)
|> IO.puts

IO.inspect("testing")
solution
|> Foo.test()
|> Enum.map(fn x -> Integer.to_string(x, 16) <> " " end)
|> IO.puts
