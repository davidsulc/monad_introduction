defmodule MaybeTest do
  use ExUnit.Case

  # (return v) >>= f ≡ f v
  test "left identity" do
    maybe_double = &(&1 * 2 |> Maybe.unit())
    val = 3

    left =
      val
      |> Maybe.unit()
      |> Maybe.flat_map(maybe_double)

    right = maybe_double.(val)

    assert left == right
  end

  # m >>= return ≡ m
  test "right identity" do
    m = 2 |> Maybe.unit()

    assert m |> Maybe.flat_map(&Maybe.unit/1) == m
  end

  # (m >>= f) >>= g ≡ m >>= ( \x -> (f x >>= g) )
  test "associativity" do
    m = 3 |> Maybe.unit()
    maybe_double = &(&1 * 2 |> Maybe.unit())
    maybe_inverse = &(&1 * (-1) |> Maybe.unit())

    left =
      m
      |> Maybe.flat_map(maybe_double)
      |> Maybe.flat_map(maybe_inverse)

    f = fn x -> maybe_double.(x) |> Maybe.flat_map(maybe_inverse) end

    right = m |> Maybe.flat_map(f)

    assert left == right
  end
end
