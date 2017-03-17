defmodule Wep.ShowController do
  use Wep.Web, :controller

  alias Wep.Show

  def index(conn, _params) do
    query = from s in Show,
            select: s.title
    shows = Repo.all(query)
    render(conn, "index.json", shows: shows)
  end

  def search(conn, %{ "title" => title }) do
    case Show.get_by_title(title) do
      nil -> render(conn, "not_found.json", message: "Show not found")
      show -> render(conn, "show.json", sh: show)
    end
  end

  # def create(conn, %{"show" => show_params}) do
  #   changeset = Show.changeset(%Show{}, show_params)
  #
  #   case Repo.insert(changeset) do
  #     {:ok, show} ->
  #       conn
  #       |> put_status(:created)
  #       |> put_resp_header("location", show_path(conn, :show, show))
  #       |> render("show.json", show: show)
  #     {:error, changeset} ->
  #       conn
  #       |> put_status(:unprocessable_entity)
  #       |> render(Wep.ChangesetView, "error.json", changeset: changeset)
  #   end
  # end
  # 
  # def show(conn, %{"id" => id}) do
  #   sh = Repo.get!(Show, id)
  #   render(conn, "show.json", sh: sh)
  # end
  #
  # def update(conn, %{"id" => id, "show" => show_params}) do
  #   show = Repo.get!(Show, id)
  #   changeset = Show.changeset(show, show_params)
  #
  #   case Repo.update(changeset) do
  #     {:ok, show} ->
  #       render(conn, "show.json", show: show)
  #     {:error, changeset} ->
  #       conn
  #       |> put_status(:unprocessable_entity)
  #       |> render(Wep.ChangesetView, "error.json", changeset: changeset)
  #   end
  # end
  #
  # def delete(conn, %{"id" => id}) do
  #   show = Repo.get!(Show, id)
  #
  #   # Here we use delete! (with a bang) because we expect
  #   # it to always work (and if it does not, it will raise).
  #   Repo.delete!(show)
  #
  #   send_resp(conn, :no_content, "")
  # end
end
