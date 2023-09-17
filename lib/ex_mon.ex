defmodule ExMon do
  @moduledoc """
  Functions to interact with the game `ExMon`.
  """

  alias ExMon.{Game, Landscape, Player}
  alias ExMon.Game.{Actions, Status}

  @doc """
  Creates a player

  ## Examples

      iex> ExMon.create_player("Laura", :punch, :heal, :kick)
      %Player{
        moves: %{
          move_avg: :punch,
          move_heal: :heal,
          move_rnd: :kick
        },
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

      iex> ExMon.create_landscape("Tokyo", ExMon.Landscape.easy_level())
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

      iex> landscape = ExMon.create_landscape("Tokyo", ExMon.Landscape.easy_level())
      iex> ExMon.create_player("Laura", :punch, :heal, :kick) |> ExMon.start_game(landscape)
  """
  def start_game(player, landscape) do
    "Robot"
    |> create_player(:punch, :heal, :kick)
    |> Game.start(player, landscape)

    Game.info() |> Status.print_round_message()
  end

  @doc """
  Makes a heal or attack movement from the current player state
  """
  def make_move(move) do
    move
    |> Actions.validate_and_find_move()
    |> perform_move()
  end

  defp perform_move({:error, move}) do
    Status.print_invalid_move_message(move)
  end

  defp perform_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Game.info() |> Status.print_round_message()
  end
end
