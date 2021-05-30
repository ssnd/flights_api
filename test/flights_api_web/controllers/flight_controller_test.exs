defmodule FlightsApiWeb.FlightControllerTest do
  use FlightsApiWeb.ConnCase

  alias FlightsApi.Flights
  alias FlightsApi.Flights.Flight

  @create_attrs %{
    arrival: ~N[2010-04-17 14:00:00],
    departure: ~N[2010-04-17 14:00:00],
    destination: "some destination",
    number: "some number",
    origin: "some origin"
  }
  @update_attrs %{
    arrival: ~N[2011-05-18 15:01:01],
    departure: ~N[2011-05-18 15:01:01],
    destination: "some updated destination",
    number: "some updated number",
    origin: "some updated origin"
  }
  @invalid_attrs %{arrival: nil, departure: nil, destination: nil, number: nil, origin: nil}

  def fixture(:flight) do
    {:ok, flight} = Flights.create_flight(@create_attrs)
    flight
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all flights", %{conn: conn} do
      conn = get(conn, Routes.flight_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create flight" do
    test "renders flight when data is valid", %{conn: conn} do
      conn = post(conn, Routes.flight_path(conn, :create), flight: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.flight_path(conn, :show, id))

      assert %{
               "id" => id,
               "arrival" => "2010-04-17T14:00:00",
               "departure" => "2010-04-17T14:00:00",
               "destination" => "some destination",
               "number" => "some number",
               "origin" => "some origin"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.flight_path(conn, :create), flight: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update flight" do
    setup [:create_flight]

    test "renders flight when data is valid", %{conn: conn, flight: %Flight{id: id} = flight} do
      conn = put(conn, Routes.flight_path(conn, :update, flight), flight: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.flight_path(conn, :show, id))

      assert %{
               "id" => id,
               "arrival" => "2011-05-18T15:01:01",
               "departure" => "2011-05-18T15:01:01",
               "destination" => "some updated destination",
               "number" => "some updated number",
               "origin" => "some updated origin"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, flight: flight} do
      conn = put(conn, Routes.flight_path(conn, :update, flight), flight: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete flight" do
    setup [:create_flight]

    test "deletes chosen flight", %{conn: conn, flight: flight} do
      conn = delete(conn, Routes.flight_path(conn, :delete, flight))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.flight_path(conn, :show, flight))
      end
    end
  end

  defp create_flight(_) do
    flight = fixture(:flight)
    %{flight: flight}
  end
end
