defmodule App do
  use GenServer

  def handle_call(pid, {:msg, data}, from, %{p: p} = state) do
    {pid, ref} =
      spawn_monitor(fn ->
        msg = %{}
        Process.send_after(self(), {:reply, from}, 1_000)
        GenServer.reply(from, msg)
      end)

    {:noreply, %{state | p: Map.put(p, {pid, ref}, from)}}
  end

  def handle_info({:reply, from}, state) do
    GenServer.reply(from, :something)
    {:noreply, state}
  end

  def handle_info({:DOWN, ref, :process, pid, :normal}, %{p: p} = state) do
    {:noreply, %{state | p: Map.delete(p, {pid, ref})}}
  end

  def handle_info({:DOWN, ref, :process, pid, reason}, %{p: p} = state) do
    from = Map.get(p, {pid, ref})
    GenServer.reply(from, {:error, reason})
    {:noreply, %{state | p: Map.delete(p, {pid, ref})}}
  end
end
