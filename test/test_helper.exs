ExUnit.start()

defmodule Assertable.Repo do
  use Ecto.Repo,
    otp_app: :assertable,
    adapter: Ecto.Adapters.Postgres
end

Application.put_env(
  :assertable,
  Assertable.Repo,
  url: "ecto://postgres:postgres@localhost/assertable_test",
  pool: Ecto.Adapters.SQL.Sandbox,
  log: false
)

defmodule Assertable.User do
  use Ecto.Schema

  schema "users" do
    field(:name, :string)
    field(:age, :integer)
    timestamps()
  end
end

defmodule Assertable.SetupMigration do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:name, :string)
      timestamps()
    end
  end
end

with :ok <- Ecto.Adapters.Postgres.storage_down(Assertable.Repo.config()),
     :ok <- Ecto.Adapters.Postgres.storage_up(Assertable.Repo.config()),
     {:ok, _pid} <- Assertable.Repo.start_link(),
     :ok <- Ecto.Migrator.up(Assertable.Repo, 0, Assertable.SetupMigration, log: false) do
  Ecto.Adapters.SQL.Sandbox.mode(Assertable.Repo, {:shared, self()})
end
