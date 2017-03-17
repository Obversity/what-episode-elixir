defmodule Wep.ShowTest do
  use Wep.ModelCase

  alias Wep.Show

  @valid_attrs %{imdb_id: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Show.changeset(%Show{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Show.changeset(%Show{}, @invalid_attrs)
    refute changeset.valid?
  end
end
