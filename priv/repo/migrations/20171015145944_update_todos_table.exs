defmodule Todone.Repo.Migrations.UpdateTodosTable do
  use Ecto.Migration

  def change do
    alter table(:todos) do
      add :user_id, references(:users)
    end
  end
end
