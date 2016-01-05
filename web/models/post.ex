defmodule AdamczDotCom.Post do
  use AdamczDotCom.Web, :model

  # defstruct [:id, :title, :date, :content, :active]
  
  schema "posts" do
    field :title, :string
    field :date, Ecto.DateTime
    field :content, :string
    field :active, :boolean, default: false

    timestamps
  end

  @required_fields ~w(title content)
  @optional_fields ~w(date)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end