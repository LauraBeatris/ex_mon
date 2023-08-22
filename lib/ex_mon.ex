defmodule ExMon do
  @moduledoc """
  Functions to interact with the game `ExMon`.
  """

  alias ExMon.{Player, Landscape}

  @doc """
  Creates a player

  ## Examples

      iex> ExMon.player(:soco, :cura, :chute, "Laura")
      %ExMon.Player{
        :soco,
        :cura,
        :chute,
        name: "Laura",
        life: 100
      }

  """
  def create_player(move_avg, move_heal, move_rnd, name) do
    Player.build(move_avg, move_heal, move_rnd, name)
  end

  def create_landscape(level, name) do
    Landscape.build(level, name)
  end
end
