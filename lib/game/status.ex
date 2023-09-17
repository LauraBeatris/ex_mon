defmodule ExMon.Game.Status do
  @moduledoc """
  Controls the output of game status
  """

  alias ExMon.Game
  alias ExMon.Player

  @doc """
  Prints round info from current state
  """
  def print_round_message(%{status: :started}) do
    landscape_name = Game.landscape() |> Map.get(:name)
    IO.puts("\n===== The game has started in #{landscape_name}! =====\n")
    Game.info() |> IO.inspect()
    IO.puts("-------------------------------------")
  end

  def print_round_message(%{status: :continue, turn: :player, player: %Player{name: player_name}}) do
    IO.puts("\n===== It's player (#{player_name}) turn! =====\n")
    Game.info() |> IO.inspect()
    IO.puts("-------------------------------------")
  end

  def print_round_message(%{
        status: :continue,
        turn: :computer,
        computer: %Player{name: computer_name}
      }) do
    IO.puts("\n===== It's computer (#{computer_name}) turn! =====\n")
    Game.info() |> IO.inspect()
    IO.puts("-------------------------------------")
  end

  def print_round_message(%{status: :game_over}) do
    IO.puts("\n===== The game is over! =====\n")
    Game.info() |> IO.inspect()
    IO.puts("-------------------------------------")
  end

  def print_invalid_move_message(move) do
    IO.puts("\n===== Invalid move: #{move} =====\n")
  end

  def print_move_message(:player, :attack, damage) do
    IO.puts("\n===== The Computer attacked the player dealing #{damage} damage. =====\n")
  end

  def print_move_message(:computer, :attack, damage) do
    IO.puts("\n===== The Player attacked the computer dealing #{damage} damage. =====\n")
  end

  def print_move_message(turn, :heal, life) do
    IO.puts(
      "\n===== The #{turn |> Atom.to_string() |> String.capitalize()} healed to #{life} =====\n"
    )
  end
end
