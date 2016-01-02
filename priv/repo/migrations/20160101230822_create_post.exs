defmodule AdamczDotCom.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :date, :datetime
      add :content, :text
      add :active, :boolean, default: true

      timestamps
    end

    create unique_index(:posts, [:title])
  end
end
