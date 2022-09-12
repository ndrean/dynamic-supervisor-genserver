defmodule OrderInit do
  use GenServer

  def start_link(name: name) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, name, name: name)
  end

  def show(name), do: GenServer.call(name, :show)

  def prepare(name), do: GenServer.cast(name, :prepare)

  def deliver(name) do
    :ok = GenServer.cast(name, :deliver)
  end

  def add(name, value) do
    GenServer.call(name, {:add, value})
  end

  @impl true
  def init(name = _state) do
    {:ok, {name, :init, 0}}
  end

  @impl true
  def handle_call(:show, _from, {_n, step, _v} = state) do
    {:reply, step, state}
  end

  @impl true
  def handle_call({:add, value}, _from, {n, s, v}) do
    {:reply, v + value, {n, s, v + value}}
  end

  @impl true
  def handle_cast(:prepare, {name, step, v}) do
    IO.inspect(step)
    Process.sleep(1_000)
    deliver(name)
    {:noreply, {name, :prepared, v}}
  end

  def handle_cast(:deliver, {name, step, v} = _state) do
    IO.inspect(step)
    Process.sleep(1_000)
    IO.inspect(:delivered)
    {:noreply, {name, :delivered, v}}
  end
end
