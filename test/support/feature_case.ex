defmodule Todone.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL

      alias Todone.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import TodoneWeb.Router.Helpers
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Todone.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Todone.Repo, {:shared, self()})
    end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(Todone.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end
end
