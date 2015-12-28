defmodule AdamczDotCom.Router do
  use AdamczDotCom.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AdamczDotCom do
    pipe_through :browser # Use the default browser stack

    get "/blog/:post", BlogController, :show
    get "/blog", BlogController, :index
    get "/about", PageController, :about
    get "/dev", PageController, :dev
    get "/music", PageController, :music
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", AdamczDotCom do
  #   pipe_through :api
  # end
end
