defmodule TecsolfacilWeb.Router do
  use TecsolfacilWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TecsolfacilWeb do
    pipe_through :api
  end
end
