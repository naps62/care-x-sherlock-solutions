defmodule Foo do
  use Bitwise

  @factor 0x000000012ACE4C7F
  @id 0xf39f
  @last 0xFFFFFFFC
  @last1 div(@last , 4) + 1
  @last2 div(@last , 4) * 2 + 2
  @last3 div(@last , 4) * 3 + 3

  def roll(seed) do
    bxor(seed, @id)
  end

  def valid?(s) do
    rem(@factor, s) != 0
  end

  def matches?(s1, s2) do
    dice = roll(s1)
    dice = dice * roll(s2)

    index = dice

    index == @last1 || index == @last2 || index == @last3
  end

  def run do
    IO.puts Integer.to_string(@last1, 16)
    IO.puts Integer.to_string(@last2, 16)
    IO.puts Integer.to_string(@last3, 16)
    for s1 <- 1..60000, s2 <- 60000..65536, s1 != s2, valid?(s1), valid?(s2), matches?(s1, s2) do
      IO.inspect("found one")
      IO.inspect(s1)
      IO.inspect(s2)
    end
  end
end

Foo.run()
