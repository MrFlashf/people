defmodule NamesDB.Client do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://api.dane.gov.pl")
  plug(Tesla.Middleware.JSON)

  def male_names do
    {:ok, %Tesla.Env{body: body}} =
      get(
        "/1.4/resources/36411,lista-imion-meskich-w-rejestrze-pesel-stan-na-24012022-imie-pierwsze/data?page=1&per_page=100"
      )

    body
    |> Jason.decode!()
    |> Map.get("data")
    |> Enum.map(fn record ->
      get_in(record, ["attributes", "col1", "val"])
    end)
  end

  def male_surnames do
    {:ok, %Tesla.Env{body: body}} =
      get("/1.4/resources/36401,nazwiska-meskie-stan-na-2022-01-27/data?page=1&per_page=100")

    body
    |> Jason.decode!()
    |> Map.get("data")
    |> Enum.map(fn record ->
      get_in(record, ["attributes", "col1", "val"])
    end)
  end

  def female_names do
    {:ok, %Tesla.Env{body: body}} =
      get(
        "/1.4/resources/36412,lista-imion-zenskich-w-rejestrze-pesel-stan-na-24012022-imie-pierwsze/data?page=1&per_page=100"
      )

    body
    |> Jason.decode!()
    |> Map.get("data")
    |> Enum.map(fn record ->
      get_in(record, ["attributes", "col1", "val"])
    end)
  end

  def female_surnames do
    {:ok, %Tesla.Env{body: body}} =
      get("/1.4/resources/36403,nazwiska-zenskie-stan-na-2022-01-27/data?page=1&per_page=100")

    body
    |> Jason.decode!()
    |> Map.get("data")
    |> Enum.map(fn record ->
      get_in(record, ["attributes", "col1", "val"])
    end)
  end
end
