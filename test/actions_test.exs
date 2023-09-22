defmodule ExMon.Game.ActionsTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.{Game, Landscape, Player}
  alias ExMon.Game
  alias ExMon.Game.Actions

  setup do
    valid_player_move = :punch
    player = Player.build("Laura", valid_player_move, :heal, :kick)
    computer = Player.build("Robot", :punch, :heal, :kick)
    landscape = Landscape.build("Tokyo", ExMon.Landscape.easy_level())

    game_start_result = computer |> Game.start(player, landscape)

    {:ok, game_start_result: game_start_result, valid_player_move: valid_player_move}
  end

  describe "heal/0" do
    test "heals the current turn player" do
      initial_computer_life = 40

      new_state = %{
        computer: %Player{
          life: initial_computer_life,
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

      capture_io(fn ->
        Actions.heal()
      end)

      assert Game.player(:computer) |> Map.get(:life) > initial_computer_life
    end
  end

  describe "attack/1" do
    test "attacks the opponent and damages life" do
      initial_player_life = Game.player(:player) |> Map.get(:life)
      intial_computer_life = Game.player(:computer) |> Map.get(:life)

      capture_io(fn ->
        Actions.attack(:move_rnd)
        Actions.attack(:move_rnd)
      end)

      updated_player_life = Game.player(:player) |> Map.get(:life)
      updated_computer_life = Game.player(:computer) |> Map.get(:life)

      assert updated_player_life < initial_player_life
      assert updated_computer_life < intial_computer_life
    end
  end

  describe "validate_and_find_move/1" do
    test "if move is invalid, returns error" do
      invalid_move = :invalid_move
      expected_validation_result = {:error, invalid_move}

      assert expected_validation_result == invalid_move |> Actions.validate_and_find_move()
    end

    test "if move is valid, returns move key", %{valid_player_move: valid_player_move} do
      expected_validation_result = {:ok, :move_avg}

      assert expected_validation_result == valid_player_move |> Actions.validate_and_find_move()
    end
  end
end
