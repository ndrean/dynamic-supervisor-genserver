defmodule GenserverExamplesTest do
  use ExUnit.Case
  doctest GenserverExamples

  test "greets the world" do
    assert GenserverExamples.hello() == :world
  end
end
