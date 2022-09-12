defmodule Shop do
  require Logger
  alias OrderInit

  def start(name: name) when is_bitstring(name) do
    name = String.to_atom(name)
    {:ok, _pid} = OrderInit.start_link(name: name)
    OrderInit.prepare(name)
  end

  def start(name: name) when is_atom(name) do
    {:ok, _pid} = OrderInit.start_link(name: name)
    OrderInit.prepare(name)
  end

  def go() do
    Enum.map(?a..?z, fn l -> Shop.start(name: <<l::utf8>>) end)
  end

  def dyn_start(name) do
    OrderDyn.new(name)
    OrderDyn.prepare(name)
  end
end
