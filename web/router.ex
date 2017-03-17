defmodule Wep.Router do
  use Wep.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  # API
  scope "/", Wep do
    pipe_through :api

    get "/shows/search", ShowController, :search
    resources "/shows", ShowController
    resources "/questions", QuestionController, except: [:new, :edit]
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/w", Wep do
    pipe_through :browser # Use the default browser stack
  end

end
