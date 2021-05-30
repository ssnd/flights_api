defmodule FlightsApi.Flights.Flight do
  use Ecto.Schema
  import Ecto.Changeset

  schema "flights" do
    field :arrival, :naive_datetime
    field :departure, :naive_datetime
    field :destination, :string
    field :number, :string
    field :origin, :string

    timestamps()
  end

  @doc false
  def changeset(flight, attrs) do
    flight
    |> cast(attrs, [:origin, :destination, :departure, :arrival, :number])
    |> validate_required([:origin, :destination, :departure, :arrival, :number])
  end
end
