defmodule AdamczDotCom.Repo.Migrations.AddPostsTags do
  use Ecto.Migration

  def change do
    create table(:posts_tags) do
      add :post_id, :integer
      add :tag_id, :integer
    end
  end
end
