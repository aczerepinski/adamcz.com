defmodule AdamczDotCom.BlogController do
  use AdamczDotCom.Web, :controller
  plug :authenticate when action in [:new, :create, :edit, :udpate]
  alias AdamczDotCom.Post

  def index(conn, _params) do
    if conn.assigns.current_user do
      posts = Repo.all(Post)
    else
      posts = Post
      |> Post.active
      |> Repo.all
    end
    render conn, "index.html", posts: posts
  end

  def show(conn, %{"slug" => slug}) do
    post = Repo.get_by(Post, slug: slug)
    if !post.active && !conn.assigns.current_user do
      conn
      |> put_flash(:error, "Sorry, only Adam gets to do that.")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
    render conn, "show.html", post: post
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"post" => post_params}) do
    changeset = Post.changeset(%Post{}, post_params)
    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "#{post.title} created")
        |> redirect(to: blog_path(conn, :index))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "oh noes something went wrong")
        |> redirect(to: blog_path(conn, :index))
    end
  end

  def edit(conn, %{"slug" => slug}) do
    post = Repo.get_by(Post, slug: slug)
    changeset = Post.changeset(post)
    render conn, "edit.html", post: post, changeset: changeset
  end

  def update(conn, %{"slug" => slug, "post" => post_params}) do
    post = Repo.get_by(Post, slug: slug)
    changeset = Post.changeset(post, post_params)
    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "#{post.title} updated")
        |> redirect(to: blog_path(conn, :show, post.slug))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "oh noes something went wrong")
        |> redirect(to: blog_path(conn, :index))
    end
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "Sorry, only Adam gets to do that.")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end

end
