defmodule Maybe do
  def unit(x), do: {:just, x}

  def nothing(), do: :nothing

  def it_or_default(monad, default) do
    case monad do
      :nothing -> default
      {:just, x} -> x
    end
  end

  def map(monad, f) do
    case monad do
      :nothing -> :nothing
      {:just, x} -> {:just, f.(x)}
    end
  end

  def flat_map(monad, f) do
    case monad do
      :nothing -> :nothing
      {:just, x} -> f.(x)
    end
  end
end
