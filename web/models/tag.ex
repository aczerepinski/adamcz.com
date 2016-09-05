defmodule AdamczDotCom.Tag do
  use AdamczDotCom.Web, :model
  import Ecto.Query
  import Ecto.Repo

  schema "tags" do
    field :name, :string
    many_to_many :posts, AdamczDotCom.Post, join_through: "post_tags"
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end

  def by_id_list(ids) do
    AdamczDotCom.Tag
      |> where([t], t.id in ^ids)
  end

end
