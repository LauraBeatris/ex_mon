defmodule ExMon.Game.Actions do
  @moduledoc """
  Performs game actions
  """

  alias ExMon.Game
  alias ExMon.Game.Actions.{Attack, Heal}

  @doc """
  Heals the current turn player
  """
  def heal() do
    case Game.turn() do
      :player -> Heal.heal_life(:player)
      :computer -> Heal.heal_life(:computer)
    end
  end

  @doc """
  Attacks the opponent with a given movement
  """
  def attack(move) do
    case Game.turn() do
      :player -> Attack.attack_opponent(:computer, move)
      :computer -> Attack.attack_opponent(:player, move)
    end
  end

  @doc """
  Fetches the movement from a player state
  """
  def validate_and_find_move(move) do
    Game.player(:player)
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
end
