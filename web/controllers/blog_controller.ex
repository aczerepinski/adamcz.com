defmodule AdamczDotCom.BlogController do
  use AdamczDotCom.Web, :controller
  plug :authenticate when action in [:new, :create, :edit, :update]
  alias AdamczDotCom.{Post, Tag}

  def index(conn, _params) do
    posts = if conn.assigns.current_user do
      Repo.all(Post)
      |> Repo.preload([tags: (from t in Tag, order_by: t.name)])
    else
      Post
      |> Post.active
      |> Post.sorted
      |> Repo.all
      |> Repo.preload([tags: (from t in Tag, order_by: t.name)])
    end
    render conn, "index.html", posts: posts
  end

  def show(conn, %{"slug" => slug}) do
    post = Repo.get_by(Post, slug: slug)
      |> Repo.preload([tags: (from t in Tag, order_by: t.name)])
    if !post.active do
      conn
      |> authenticate({})
    end
    render conn, "show.html", post: post
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{tags: []})
    tags = Repo.all(Tag)
    render conn, "new.html", changeset: changeset, tags: tags
  end

  def create(conn, %{"post" => post_params, "tags" => tags}) do
    tags_to_associate = tag_changeset(tags)
    changeset = Post.changeset(%Post{}, post_params)
      |> Ecto.Changeset.put_assoc(:tags, tags_to_associate)
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
      |> Repo.preload(:tags)
    tags = Repo.all(Tag)
    changeset = Post.changeset(post)
    render conn, "edit.html", post: post, changeset: changeset, tags: tags
  end

  def update(conn, %{"slug" => slug, "post" => post_params, "tags" => tags}) do
    tags_to_associate = tag_changeset(tags)
    post = Repo.get_by(Post, slug: slug)
      |> Repo.preload(:tags)
    changeset = Post.changeset(post, post_params)
      |> Ecto.Changeset.put_assoc(:tags, tags_to_associate)

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

  defp tags_to_list(tags) do
    Enum.filter_map(tags, fn(tag) -> String.to_atom(elem(tag, 1)) == true end,
      fn(tag) -> String.to_integer(elem(tag, 0)) end)
  end

  defp get_tag_structs(tag_list) do
    AdamczDotCom.Tag.by_id_list(tag_list)
    |> Repo.all
  end

  defp tag_changeset(tags) do
    tags_to_list(tags) # maps params to list of integers
    |> get_tag_structs # gets structs
    |> Enum.map(&Ecto.Changeset.change/1)
  end

end
