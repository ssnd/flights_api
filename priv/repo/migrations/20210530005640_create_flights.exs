defmodule FlightsApi.Repo.Migrations.CreateFlights do
  use Ecto.Migration

  def change do
    create table(:flights) do
      add :origin, :string
      add :destination, :string
      add :departure, :naive_datetime
      add :arrival, :naive_datetime
      add :number, :string

      timestamps()
    end

  end
end
