defmodule ExMon.Game.Status do
  @moduledoc """
  Controls the output of game status
  """

  alias ExMon.Game

  @doc """
  Prints round info from current state
  """
  def print_round_message do
    landscape_name = Game.landscape() |> Map.get(:name)
    IO.puts("\n===== The game has started in #{landscape_name}! =====\n")
    Game.info() |> IO.inspect()
    IO.puts("-------------------------------------")
  end

  def print_invalid_move_message(move) do
    IO.puts("\n===== Invalid move: #{move} =====\n")
  end
end