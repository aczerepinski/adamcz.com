defmodule AdamczDotCom.BlogController do
  use AdamczDotCom.Web, :controller
  alias AdamczDotCom.Post

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, _params) do
    render conn, "show.html"
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render conn, "new.html", changeset: changeset
  end
end
