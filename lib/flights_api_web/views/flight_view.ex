defmodule FlightsApiWeb.FlightView do
  use FlightsApiWeb, :view
  alias FlightsApiWeb.FlightView

  def render("index.json", %{flights: flights}) do
    %{data: render_many(flights, FlightView, "flight.json")}
  end

  def render("show.json", %{flight: flight}) do
    %{data: render_one(flight, FlightView, "flight.json")}
  end

  def render("flight.json", %{flight: flight}) do
    %{id: flight.id,
      origin: flight.origin,
      destination: flight.destination,
      departure: flight.departure,
      arrival: flight.arrival,
      number: flight.number}
  end
end
