defmodule ExMon.Landscape do
  @moduledoc """
  Represents a landscape from the game
  """

  @easy_level 1
  @intermediate_level 2
  @difficult_level 3

  use TypedStruct

  @min_level 1

  typedstruct do
    field(:name, String.t(), enforce: true)
    field(:level, integer(), default: @min_level)
  end

  def build(level, name) do
    %ExMon.Landscape{
      level: level,
      name: name
    }
  end
end
