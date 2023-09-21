defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.{Landscape, Player}

  describe "create_player/4" do
    test "returns a player" do
      expected_player = %Player{
        life: 100,
        moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
        name: "Laura"
      }

      assert expected_player == ExMon.create_player("Laura", :punch, :heal, :kick)
    end
  end

  describe "create_landscape/2" do
    test "returns a landscape" do
      expected_landscape = %Landscape{level: 1, name: "Tokyo"}

      assert expected_landscape == ExMon.create_landscape("Tokyo", Landscape.easy_level())
    end
  end

  describe "start_game/2" do
    test "returns a message when the game has started" do
      player = Player.build("Laura", :punch, :heal, :kick)
      landscape = Landscape.build("Tokyo", ExMon.Landscape.easy_level())

      captured_message =
        capture_io(fn ->
          assert player |> ExMon.start_game(landscape) == :ok
        end)

      assert captured_message =~ "The game has started in Tokyo!"
      assert captured_message =~ "status: :started"
      assert captured_message =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Laura", :punch, :heal, :kick)
      landscape = Landscape.build("Tokyo", ExMon.Landscape.easy_level())

      capture_io(fn ->
        player |> ExMon.start_game(landscape)
      end)

      :ok
    end

    test "when the move is valid, do the move and the computer makes a move" do
      captured_message =
        capture_io(fn ->
          ExMon.make_move(:kick)
        end)

      assert captured_message =~ "The Player attacked the computer"
      assert captured_message =~ "It's computer (Robot) turn"
      assert captured_message =~ "It's player (Laura) turn"
      assert captured_message =~ "status: :continue"
    end

    test "when the move is invalid, returns an error message" do
      captured_message =
        capture_io(fn ->
          ExMon.make_move(:invalid_move)
        end)

      assert captured_message =~ "Invalid move: invalid_move"
    end
  end
end
