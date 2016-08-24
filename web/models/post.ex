defmodule AdamczDotCom.Post do
  use AdamczDotCom.Web, :model
  alias AdamczDotCom.Repo

  schema "posts" do
    field :title, :string
    field :date, Ecto.DateTime
    field :content, :string
    field :active, :boolean, default: false
    field :slug, :string
    many_to_many :tags, AdamczDotCom.Tag, join_through: "posts_tags",
      on_replace: :delete

    timestamps
  end

  def changeset(post, params \\ %{}) do
    post
    |> cast(params, [:title, :date, :content, :active, :slug])
    |> cast_assoc(:tags)
    |> validate_required([:title, :content])
    |> create_a_slug
  end

  defp create_a_slug(changeset) do
    case fetch_field(changeset, :title) do
      {:changes, title} ->
        slug = title |> slugify
        put_change(changeset, :slug, slug)
      _ ->
        changeset
    end
  end

  defp slugify nil do
    nil
  end

  defp slugify(string) do
    string
    |> String.downcase
    |> String.replace(" ", "-")
    |> String.replace(~r/[!.?']/, "")
  end

  def active(query) do
    from p in query, where: p.active == true,
      preload: [:tags]
  end

  def sorted(query) do
    from p in query, order_by: [desc: p.date]
  end

end