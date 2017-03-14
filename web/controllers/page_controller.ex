defmodule Wep.PageController do
  use Wep.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
