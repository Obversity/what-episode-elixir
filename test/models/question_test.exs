defmodule Wep.QuestionTest do
  use Wep.ModelCase

  alias Wep.Question

  @valid_attrs %{bit: "some content", flag_count: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Question.changeset(%Question{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Question.changeset(%Question{}, @invalid_attrs)
    refute changeset.valid?
  end
end
