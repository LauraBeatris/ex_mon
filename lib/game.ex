defmodule ExMon.Game do
  @moduledoc """
  Manages the game state
  """

  use Agent

  @doc """
  Starts the game state

  ## Examples

    iex> player = ExMon.create_player("Laura", :punch, :heal, :kick)
    iex> landscape = ExMon.create_landscape("Tokyo", Landscape.easy_level())
    iex> ExMon.create_player("Robot", :punch, :heal, :kick) |> Game.start(player, landscape)
  """
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

  @doc """
  Retrieves the game state
  """
  def info do
    Agent.get(__MODULE__, & &1)
  end

  @doc """
  Retrieves the player state
  """
  def player do
    info() |> Map.get(:player)
  end
end
