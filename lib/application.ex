defmodule GenserverExamples.Application do
  use Application

  @impl true
  def start(_, _) do
    children = [
      {Registry, keys: :unique, name: MyRegistry},
      {DynamicSupervisor, strategy: :one_for_one, name: DynSup}
    ]

    Supervisor.start_link(
      children,
      strategy: :one_for_one,
      name: GenserverExamples.Supervisor
    )
  end
end
