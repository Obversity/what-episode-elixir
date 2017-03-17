defmodule Wep.QuestionView do
  use Wep.Web, :view

  def render("index.json", %{questions: questions}) do
    %{data: render_many(questions, Wep.QuestionView, "question.json")}
  end

  def render("show.json", %{question: question}) do
    %{data: render_one(question, Wep.QuestionView, "question.json")}
  end

  def render("question.json", %{question: question}) do
    %{id: question.id,
      bit: question.bit,
      episode_id: question.episode_id}
  end
end
