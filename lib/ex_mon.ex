defmodule ExMon do
  @moduledoc """
  Functions to interact with the game `ExMon`.
  """

  alias ExMon.{Game, Landscape, Player}

  @doc """
  Creates a player

  ## Examples

      iex> ExMon.create_player("Laura", :soco, :cura, :chute)
      %Player{
        :soco,
        :cura,
        :chute,
        name: "Laura",
        life: 100
      }

  """
  def create_player(name, move_avg, move_heal, move_rnd) do
    Player.build(name, move_avg, move_heal, move_rnd)
  end

  @doc """
  Creates a landscape

  ## Examples

      iex> ExMon.create_landscape("Tokyo", Landscape.easy_level())
      %Landscape{
        level: 1,
        name: "Tokyo"
      }

  """
  def create_landscape(name, level) do
    Landscape.build(name, level)
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
  def start_game(player, landscape) do
    "Robot"
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player, landscape)
  end
end
