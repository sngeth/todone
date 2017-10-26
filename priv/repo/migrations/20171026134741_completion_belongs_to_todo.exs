defmodule Todone.Repo.Migrations.CompletionBelongsToTodo do
  use Ecto.Migration

  def change do
    alter table(:completions) do
      add :todo_id, references(:todos)
    end
  end
end
