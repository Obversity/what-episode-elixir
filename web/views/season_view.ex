defmodule Wep.SeasonView do
  use Wep.Web, :view

  def render("season.json", %{season: season}) do
    %{
      id: season.id,
      number: season.number,
      episodes: render_many(season.episodes, Wep.EpisodeView, "episode.json")
     }
  end
end
