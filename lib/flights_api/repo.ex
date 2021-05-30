defmodule FlightsApi.Repo do
  use Ecto.Repo,
    otp_app: :flights_api,
    adapter: Ecto.Adapters.Postgres
end
