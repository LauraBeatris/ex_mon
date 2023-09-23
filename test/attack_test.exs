defmodule ExMon.Game.Actions.AttackTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Game.Actions.Attack
  alias ExMon.{Game, Landscape, Player}

  setup do
    player = Player.build("Laura", :punch, :heal, :kick)
    computer = Player.build("Robot", :punch, :heal, :kick)
    landscape = Landscape.build("Tokyo", ExMon.Landscape.easy_level())

    game_start_result = computer |> Game.start(player, landscape)

    {:ok, game_start_result: game_start_result}
  end

  describe "attack_opponent/2" do
    test "damages opponent life" do
      opponent = :computer

      initial_opponent_life = opponent |> Game.player() |> Map.get(:life)

      capture_io(fn ->
        opponent |> Attack.attack_opponent(:move_avg)
      end)

      damaged_opponent_life = opponent |> Game.player() |> Map.get(:life)

      assert damaged_opponent_life < initial_opponent_life
    end

    test "prints move message" do
      opponent = :computer

      captured_message =
        capture_io(fn ->
          opponent |> Attack.attack_opponent(:move_avg)
        end)

      assert captured_message =~ "The Player attacked the computer"
    end
  end
end
