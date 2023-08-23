defmodule ExMon.Landscape do
  @moduledoc """
  Represents a landscape from the game
  """

  def easy_level, do: 1
  def intermediate_level, do: 2
  def difficult_level, do: 3

  use TypedStruct

  @min_level 1

  typedstruct do
    field(:name, String.t(), enforce: true)
    field(:level, integer(), default: @min_level)
  end

  def build(name, level) do
    %ExMon.Landscape{
      name: name,
      level: level
    }
  end
end
