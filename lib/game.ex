defmodule ExMon.Game do
  @moduledoc """
  Manages the game state
  """

  alias ExMon.Player
  use Agent

  @doc """
  Starts the game state

  ## Examples

    iex> player = ExMon.create_player("Laura", :punch, :heal, :kick)
    iex> landscape = ExMon.create_landscape("Tokyo", ExMon.Landscape.easy_level())
    iex> ExMon.create_player("Robot", :punch, :heal, :kick) |> Game.start(player, landscape)
  """
  def start(computer, player, landscape) do
    initial_value = %{
      turn: :player,
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
  def player(:computer), do: info() |> Map.get(:computer)
  def player(:player), do: info() |> Map.get(:player)

  @doc """
  Retrieves the landscape state
  """
  def landscape do
    info() |> Map.get(:landscape)
  end

  @doc """
  Retrieves the turn state
  """
  def turn do
    info() |> Map.get(:turn)
  end

  @doc """
  Updates the entire game state
  """
  def update(state) do
    Agent.update(__MODULE__, fn _ -> update_game_state(state) end)
  end

  defp update_game_state(
         %{player: %Player{life: player_life}, computer: %{life: computer_life}} = state
       )
       when player_life == 0 or computer_life == 0,
       do: Map.put(state, :status, :game_over)

  defp update_game_state(state) do
    state
    |> Map.put(:status, :continue)
    |> update_turn
  end

  defp update_turn(%{turn: :player} = state), do: Map.put(state, :turn, :computer)
  defp update_turn(%{turn: :computer} = state), do: Map.put(state, :turn, :player)
end
