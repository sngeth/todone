defmodule Todone.Repo.Migrations.TodosBelongToCategories do
  use Ecto.Migration

  def change do
    alter table(:todos) do
      add :category_id, references(:categories)
    end

    create index(:todos, [:category_id])
  end
end
