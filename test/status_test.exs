defmodule ExMon.Game.StatusTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.{Game, Player, Landscape}
  alias ExMon.Game.{Status}

  describe "print_round_message/1" do
    setup do
      player = Player.build("Laura", :punch, :heal, :kick)
      computer = Player.build("Robot", :punch, :heal, :kick)
      landscape = Landscape.build("Tokyo", ExMon.Landscape.easy_level())

      computer |> Game.start(player, landscape)

      :ok
    end

    test "prints that the game has started" do
      captured_message =
        capture_io(fn ->
          Game.info() |> Status.print_round_message()
        end)

      assert captured_message =~ "The game has started in Tokyo!"
    end

    test "prints that it's computer turn" do
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

      captured_message =
        capture_io(fn ->
          Game.info() |> Status.print_round_message()
        end)

      assert captured_message =~ "It's computer (Robot) turn!"
    end

    test "prints that it's player turn" do
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
        turn: :computer
      }

      new_state |> Game.update()

      captured_message =
        capture_io(fn ->
          Game.info() |> Status.print_round_message()
        end)

      assert captured_message =~ "It's player (Laura) turn!"
    end

    test "prints that the game is over" do
      new_state = %{
        computer: %Player{
          life: 0,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Robot"
        },
        landscape: %Landscape{level: 1, name: "Tokyo"},
        player: %Player{
          life: 50,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Laura"
        },
        status: :game_over,
        turn: :computer
      }

      new_state |> Game.update()

      captured_message =
        capture_io(fn ->
          Game.info() |> Status.print_round_message()
        end)

      assert captured_message =~ "The game is over!"
    end
  end

  describe "print_invalid_move_message/1" do
    test "prints that the move is invalid" do
      captured_message =
        capture_io(fn ->
          Status.print_invalid_move_message(:invalid_move)
        end)

      assert captured_message =~ "Invalid move: invalid_move"
    end
  end

  describe "print_move_message/3" do
    test "when the computer attacks a player, prints message with damage" do
      mocked_damage = 20

      captured_message =
        capture_io(fn ->
          Status.print_move_message(:player, :attack, mocked_damage)
        end)

      assert captured_message =~ "The Computer attacked the player dealing 20 damage"
    end

    test "when the player attacks a computer, prints message with damage" do
      mocked_damage = 20

      captured_message =
        capture_io(fn ->
          Status.print_move_message(:computer, :attack, mocked_damage)
        end)

      assert captured_message =~ "The Player attacked the computer dealing 20 damage"
    end

    test "when it's heal movement, prints message with healed life" do
      mocked_life = 20

      captured_message =
        capture_io(fn ->
          Status.print_move_message(:computer, :heal, mocked_life)
        end)

      assert captured_message =~ "The Computer healed to 20"
    end
  end
end
