defmodule OrderDyn do
  def via_tuple(name) do
    {:via, Registry, {MyRegistry, name}}
  end

  def new(name) do
    DynamicSupervisor.start_child(
      DynSup,
      {OrderInit, [name: via_tuple(name)]}
    )
  end

  def show(name) do
    name |> via_tuple |> OrderInit.show()
    # GenServer.call(via_tuple(name), :show)
  end

  def prepare(name) do
    name |> via_tuple |> OrderInit.prepare()
    # GenServer.call(via_tuple(name), :prepare)
  end

  # def deliver(name) do
  #   :ok = GenServer.cast(name, {:deliver})
  # end
  # def prepare(name) do
  #   GenServer.cast(via_tuple(name), {:prepare})
  # end

  # def show(name) do
  #   GenServer.call(via_tuple(name), :show)
  # end

  # def deliver(name) do
  #   :ok = GenServer.cast(via_tuple(name), {:deliver})
  # end

  def add(name) do
    name |> via_tuple |> OrderInit.add()
  end

  # def add(name, value) do
  #   GenServer.call(via_tuple(name), {:add, value})
  # end
end
