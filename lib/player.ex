defmodule ExMon.Player do
  @moduledoc """
  Represents a player with their movements and life
  """

  @player_keys [:life, :moves, :name]
  @max_life 100

  @enforce_keys @player_keys
  defstruct @player_keys

  def build(name, move_avg, move_heal, move_rnd) do
    %ExMon.Player{
      moves: %{
        move_avg: move_avg,
        move_heal: move_heal,
        move_rnd: move_rnd
      },
      name: name,
      life: @max_life
    }
  end
end
