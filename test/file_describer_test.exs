defmodule FileDescriberTest do
  use ExUnit.Case
  doctest FileDescriber

  test "greets the world" do
    assert FileDescriber.hello() == :world
  end
end
