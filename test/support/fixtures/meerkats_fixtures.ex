defmodule Tutorial.MeerkatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tutorial.Meerkats` context.
  """

  @doc """
  Generate a meerkat.
  """
  def meerkat_fixture(attrs \\ %{}) do
    {:ok, meerkat} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Tutorial.Meerkats.create_meerkat()

    meerkat
  end
end
