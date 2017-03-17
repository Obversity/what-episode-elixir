defmodule Wep.EpisodeView do
  use Wep.Web, :view

  def render("episode.json", %{episode: episode}) do
    %{id: episode.id,
      season_id: episode.season_id,
      title: episode.title,
      number: episode.number,
      imdb_id: episode.imdb_id,
      questions: render_many(episode.questions, Wep.QuestionView, "question.json")
    }
  end
end
