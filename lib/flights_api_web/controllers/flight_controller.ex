defmodule FlightsApiWeb.FlightController do
  use FlightsApiWeb, :controller

  alias FlightsApi.Flights
  alias FlightsApi.Flights.Flight

  action_fallback FlightsApiWeb.FallbackController

  def index(conn, _params) do
    flights = Flights.list_flights()
    render(conn, "index.json", flights: flights)
  end

  def create(conn, %{"flight" => flight_params}) do
    with {:ok, %Flight{} = flight} <- Flights.create_flight(flight_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.flight_path(conn, :show, flight))
      |> render("show.json", flight: flight)
    end
  end

  def show(conn, %{"id" => id}) do
    flight = Flights.get_flight!(id)
    render(conn, "show.json", flight: flight)
  end

  def update(conn, %{"id" => id, "flight" => flight_params}) do
    flight = Flights.get_flight!(id)

    with {:ok, %Flight{} = flight} <- Flights.update_flight(flight, flight_params) do
      render(conn, "show.json", flight: flight)
    end
  end

  def delete(conn, %{"id" => id}) do
    flight = Flights.get_flight!(id)

    with {:ok, %Flight{}} <- Flights.delete_flight(flight) do
      send_resp(conn, :no_content, "")
    end
  end
end
