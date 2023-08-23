defmodule ExMon do
  @moduledoc """
  Functions to interact with the game `ExMon`.
  """

  alias ExMon.{Landscape, Player, Game}

  @doc """
  Creates a player

  ## Examples

      iex> ExMon.Player(:soco, :cura, :chute, "Laura")
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

  @doc """
  Creates a landscape

  ## Examples

      iex> ExMon.Landscape(ExMon.Landscape.attribute(:easy_level), :cura, :chute, "Tokyo")
      %ExMon.Landscape{
        level: 1,
        name: "Tokyo"
      }

  """
  def create_landscape(level, name) do
    Landscape.build(level, name)
  end

  @doc """
  Starts the game and stores that state via Agent

  ## Examples

      iex> ExMon.Landscape(ExMon.Landscape.attribute(:easy_level), :cura, :chute, "Tokyo")
      %ExMon.Landscape{
        level: 1,
        name: "Tokyo"
      }

  """
  def start_game(player) do
    "Robot"
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)
  end
end
