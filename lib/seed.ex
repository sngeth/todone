defmodule Mix.Tasks.Todone.Seed do
  use Mix.Task
  alias Todone.Repo
  alias Todone.Repo
  alias Todone.Categories.Category

  def run(_) do
    Mix.Task.run "app.start", []
    seed(Mix.env)
  end

  def seed(:test) do
    # do nothing
  end

  def seed(:dev) do
    Repo.delete_all Category

    Repo.insert! %Category{
      name: "Career"
    }

    Repo.insert! %Category{
      name: "Health"
    }
  end
end
