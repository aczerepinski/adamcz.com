defmodule AdamczDotCom.PageController do
  use AdamczDotCom.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def about(conn, _params) do
    render conn, "about.html"
  end

  def dev(conn, _params) do
    render conn, "dev.html"
  end

  def music(conn, _params) do
    render conn, "music.html"
  end

  def resume(conn, _params) do
    render conn, "resume.html"
  end
end
