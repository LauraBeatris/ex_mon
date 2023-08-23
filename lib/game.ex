defmodule ExMon.Game do
  use Agent

  def start(computer, player, landscape) do
    initial_value = %{
      turn: player,
      player: player,
      status: :started,
      computer: computer,
      landscape: landscape
    }

    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def info do
    Agent.get(__MODULE__, & &1)
  end
end
