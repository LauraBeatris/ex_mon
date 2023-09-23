defmodule ExMon.Game.Actions.Heal do
  @moduledoc """
  Performs heal action
  """

  @heal_power 18..25

  alias ExMon.Game
  alias ExMon.Game.Status

  def heal_life(turn) do
    turn
    |> Game.player()
    |> Map.get(:life)
    |> calculate_total_life()
    |> set_life(turn)
  end

  defp calculate_total_life(life), do: Enum.random(@heal_power) + life

  defp set_life(life, turn) when life > 100, do: update_player_life(turn, 100)
  defp set_life(life, turn), do: update_player_life(turn, life)

  defp update_player_life(turn, life) do
    turn
    |> Game.player()
    |> Map.put(:life, life)
    |> update_game(turn, life)
  end

  defp update_game(player_state, turn, life) do
    Game.info()
    |> Map.put(turn, player_state)
    |> Game.update()

    Status.print_move_message(turn, :heal, life)
  end
end
