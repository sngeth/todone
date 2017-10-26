defmodule Todone.Repo.Migrations.CreateCompletion do
  use Ecto.Migration

  def change do
    create table(:completions) do
      timestamps()
    end
  end
end
