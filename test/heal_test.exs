defmodule ExMon.Game.Actions.HealTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Game.Actions.Heal
  alias ExMon.{Game, Landscape, Player}

  setup do
    player = Player.build("Laura", :punch, :heal, :kick)
    computer = Player.build("Robot", :punch, :heal, :kick)
    landscape = Landscape.build("Tokyo", ExMon.Landscape.easy_level())

    game_start_result = computer |> Game.start(player, landscape)

    {:ok, game_start_result: game_start_result}
  end

  describe "heal_life/1" do
    test "updates player life state" do
      initial_player_life = 50

      new_state = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Robot"
        },
        landscape: %Landscape{level: 1, name: "Tokyo"},
        player: %Player{
          life: initial_player_life,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Laura"
        },
        status: :started,
        turn: :player
      }

      new_state |> Game.update()

      capture_io(fn ->
        :player |> Heal.heal_life()
      end)

      healed_player_life = :player |> Game.player() |> Map.get(:life)

      assert healed_player_life > initial_player_life
    end

    test "prints move message" do
      initial_player_life = 50

      new_state = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Robot"
        },
        landscape: %Landscape{level: 1, name: "Tokyo"},
        player: %Player{
          life: initial_player_life,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Laura"
        },
        status: :started,
        turn: :player
      }

      new_state |> Game.update()

      captured_message =
        capture_io(fn ->
          :player |> Heal.heal_life()
        end)

      assert captured_message =~ "The Player healed"
    end
  end
end
