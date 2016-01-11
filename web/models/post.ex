defmodule AdamczDotCom.Post do
  use AdamczDotCom.Web, :model

  schema "posts" do
    field :title, :string
    field :date, Ecto.DateTime
    field :content, :string
    field :active, :boolean, default: false
    field :slug, :string

    timestamps
  end

  @required_fields ~w(title content)
  @optional_fields ~w(date active slug)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
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
    |> String.replace(" ", "_")
  end
end