defmodule ExMon.Game.Actions.Attack do
  @moduledoc """
  Performs attack actions
  """

  alias ExMon.Game
  alias ExMon.Game.Status

  @move_avg_damage 18..25
  @move_rnd_damage 10..35

  def attack_opponent(opponent, move) do
    damage = calculate_damage(move)

    opponent
    |> Game.player()
    |> Map.get(:life)
    |> calculate_total_life(damage)
    |> update_opponent_life(opponent)

    Status.print_move_message(opponent, :attack, damage)
  end

  defp calculate_damage(:move_avg), do: Enum.random(@move_avg_damage)
  defp calculate_damage(:move_rnd), do: Enum.random(@move_rnd_damage)

  defp calculate_total_life(life, damage) when damage > life, do: 0
  defp calculate_total_life(life, damage), do: life - damage

  defp update_opponent_life(life, opponent) do
    opponent
    |> Game.player()
    |> Map.put(:life, life)
    |> update_opponent_state(opponent)
  end

  defp update_opponent_state(player, opponent) do
    Game.info()
    |> Map.put(opponent, player)
    |> Game.update()
  end
end
