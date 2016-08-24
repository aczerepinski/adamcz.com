defmodule AdamczDotCom.Router do
  use AdamczDotCom.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug AdamczDotCom.Auth, repo: AdamczDotCom.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AdamczDotCom do
    pipe_through :browser # Use the default browser stack
    resources "/users", UserController, only: [:index, :show, :new, :create, :edit, :udpate, :delete]
    resources "/blog", BlogController, only: [:index, :show, :new, 
        :create, :edit, :update], param: "slug"
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/tags", TagController, only: [:index, :show, :new, :create, :edit, :udpate, :delete]
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
