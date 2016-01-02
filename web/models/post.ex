defmodule AdamczDotCom.Post do
  use AdamczDotCom.Web, :model

  defstruct [:id, :title, :date, :content, :active]
  
  schema "posts" do
    field :title, :string
    field :date, Ecto.DateTime
    field :content
    field :active, :boolean, default: false
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(title content), [])
  end
end