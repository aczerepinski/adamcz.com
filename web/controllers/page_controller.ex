defmodule AdamczDotCom.PageController do
  use AdamczDotCom.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
