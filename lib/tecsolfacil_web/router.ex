defmodule TecsolfacilWeb.Router do
  use TecsolfacilWeb, :router
  alias TecsolfacilWeb.Api.V1.AuthErrorHandler

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authentication do
    plug Guardian.Plug.Pipeline, module: Tecsolfacil.Accounts.Guardian, error_handler: AuthErrorHandler

    plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
  end

  scope "/api/v1", TecsolfacilWeb.Api.V1 do
    pipe_through :api

    post "/user/token", UserController, :generate_token
  end

  scope "/api/v1", TecsolfacilWeb.Api.V1 do
    pipe_through [:api, :authentication]

    post "/address/report", AddressController, :report
    get "/address/:cep", AddressController, :show
  end
end
