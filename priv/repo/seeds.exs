# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FlightsApi.Repo.insert!(%FlightsApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
defmodule PopulateScript do
    require Logger
    alias FlightsApi.Flights
    @doc "Import flight data from a CSV file"
    def csv_import() do
        File.stream!("initial_data.csv")
        |> CSV.decode(separator: ?,, headers: true)
        |> Stream.each(fn row -> 

            {:ok, row_data} = row
            {:ok, arrival} = row_data 
            |> process_flight_datetime("ArrivalDate", "ArrivalTime")

            {:ok, departure} = row_data 
            |> process_flight_datetime("DepartureDate", "DepartureTime")


            Flights.create_flight(%{arrival: arrival, 
                                    departure: departure, 
                                    destination: row_data["Destination"], 
                                    origin: row_data["Origin"], 
                                    id: row_data["Id"],
                                    number: row_data["Number"]})

        end)
        |> Stream.run
    end

    defp process_flight_datetime(row, date_key, time_key) do
        year = String.slice(row[date_key], 0..3)
        month = String.slice(row[date_key], 4..5)
        day = String.slice(row[date_key], 6..7)

        hour = String.slice(row[time_key], 0..1)
        minute = String.slice(row[time_key], 2..3)

        NaiveDateTime.from_iso8601 "#{year}-#{month}-#{day} #{hour}:#{minute}:00"
        
    end

end


PopulateScript.csv_import()