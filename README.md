# FlightsApi 

## Description  
This project creates a simple API based on a [CSV file](https://github.com/ssnd/flights_api/blob/main/initial_data.csv) with flight info using Docker, Phoenix Framework and Elixir.   

The app and provides two endpoints to access the saved data:
 * `/api/flights` to get a list of flights in the database.
 * `/api/flights/:id` to get info about a specific flight.

Because reading from a CSV file is slow and resource-intensive, I decided to process the provided CSV file on app launch and populate the Postgre database with the provided data.
Even though this solution may seem a little over-engineered, database pre-population is better because of the following few reasons:
 * It allows us to work with bigger initial CSV datasets.
 * Uses less time and resources than the strategy of reading the CSV file each time a request happens.
 * Is more reliable than reading the CSV file on app launch and keeping it in-memory. An app crash would mean we should read it again, while the database just keeps our data safe.
 * It is a more scalable and production-ready solution.

## Launch with Docker
  * `docker-compose up` in the root directory will launch the app. Open [`localhost:4000/api/flights`](http://localhost:4000/api/flights) to use the API.
  * `docker-compose down --volumes` to clean the database data before relaunching.
  * You can change the Docker launch environment settings in the [`staging.exs`](https://github.com/ssnd/flights_api/blob/main/config/staging.exs) file. Note that you will have to launch the app using the cli for the web pages to reload automatically.

## Launch with Phoenix CLI
Prerequisistes: npm, elixir, postgre and phoenix framework.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

