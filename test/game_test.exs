defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Landscape, Player}

  setup do
    player = Player.build("Laura", :punch, :heal, :kick)
    computer = Player.build("Robot", :punch, :heal, :kick)
    landscape = Landscape.build("Tokyo", ExMon.Landscape.easy_level())

    game_start_result = computer |> Game.start(player, landscape)

    {:ok, game_start_result: game_start_result}
  end

  describe "start/2" do
    test "starts the game state", %{game_start_result: game_start_result} do
      assert {:ok, _pid} = game_start_result
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      expected_state = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Robot"
        },
        landscape: %Landscape{level: 1, name: "Tokyo"},
        player: %Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Laura"
        },
        status: :started,
        turn: :player
      }

      assert expected_state === Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      expected_initial_state = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Robot"
        },
        landscape: %Landscape{level: 1, name: "Tokyo"},
        player: %Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Laura"
        },
        status: :started,
        turn: :player
      }

      assert expected_initial_state === Game.info()

      new_state = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Robot"
        },
        landscape: %Landscape{level: 1, name: "Tokyo"},
        player: %Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Laura"
        },
        status: :started,
        turn: :player
      }

      new_state |> Game.update()

      expected_updated_state = %{new_state | turn: :computer, status: :continue}

      assert expected_updated_state == Game.info()
    end
  end

  describe "player/1" do
    test "returns the player state" do
      expected_player = %Player{
        life: 100,
        moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
        name: "Laura"
      }

      assert expected_player == Game.player(:player)
    end

    test "returns the computer state" do
      expected_player = %Player{
        life: 100,
        moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
        name: "Robot"
      }

      assert expected_player == Game.player(:computer)
    end
  end

  describe "landscape/0" do
    test "returns the landscape state" do
      expected_landscape = %Landscape{level: 1, name: "Tokyo"}

      assert expected_landscape == Game.landscape()
    end
  end

  describe "turn/0" do
    test "returns the turn state" do
      assert :player == Game.turn()
    end
  end
end
