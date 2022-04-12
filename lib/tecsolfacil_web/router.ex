defmodule TecsolfacilWeb.Router do
  use TecsolfacilWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", TecsolfacilWeb.Api.V1 do
    pipe_through :api

    get "/address/:cep", AddressController, :show
  end
end
