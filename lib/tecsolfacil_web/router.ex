defmodule TecsolfacilWeb.Router do
  use TecsolfacilWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", TecsolfacilWeb.Api.V1 do
    pipe_through :api

    post "/user/token", UserController, :generate_token
    post "/address/report", AddressController, :report
    get "/address/:cep", AddressController, :show
  end
end
