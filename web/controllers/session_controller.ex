defmodule AdamczDotCom.SessionController do
  use AdamczDotCom.Web, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"username" => user, "password" =>
                                    pass}}) do
    case AdamczDotCom.Auth.login_by_username_and_pass(conn, user, pass, repo:
                                                      Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Logged in.")
        |> redirect(to: blog_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "No sir.")
        |> render("new.html")                                                    
    end          
  end

  def delete(conn, _) do
    conn
    |> AdamczDotCom.Auth.logout()
    |> put_flash(:info, "Logged out.")
    |> redirect(to: page_path(conn, :index))
  end

end