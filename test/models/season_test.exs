defmodule Wep.SeasonTest do
  use Wep.ModelCase

  alias Wep.Season

  @valid_attrs %{number: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Season.changeset(%Season{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Season.changeset(%Season{}, @invalid_attrs)
    refute changeset.valid?
  end
end
