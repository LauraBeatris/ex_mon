defmodule ExMon.Game.Actions do
  @moduledoc """
  Performs game actions
  """

  alias ExMon.Game
  alias ExMon.Game.Status

  @doc """
  Fetches the movement from a player state
  """
  def fetch_move(move) do
    Game.player()
    |> Map.get(:moves)
    |> find_move(move)
  end

  @doc """
  Finds a movement from a given movements enum
  """
  def find_move(player_moves, chosen_move) do
    player_moves
    |> Enum.find_value({:error, chosen_move}, fn {key, value} ->
      if value === chosen_move, do: {:ok, key}
    end)
  end

  def perform_move({:error, move}) do
    Status.print_invalid_move_message(move)
  end

  def perform_move({:ok, move}) do
    case move do
      :move_heal -> "perform_heal"
      move -> "attack"
    end
  end
end
