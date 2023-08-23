defmodule ExMon.Player do
  @moduledoc """
  Represents a player with their movements and life
  """

  @player_keys [:life, :move_avg, :move_heal, :move_rnd, :name]
  @max_life 100

  @enforce_keys @player_keys
  defstruct @player_keys

  def build(move_avg, move_heal, move_rnd, name) do
    %ExMon.Player{
      move_avg: move_avg,
      move_heal: move_heal,
      move_rnd: move_rnd,
      name: name,
      life: @max_life
    }
  end
end