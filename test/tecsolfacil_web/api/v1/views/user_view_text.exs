defmodule TecsolfacilWeb.Api.V1.UserViewTest do
  use TecsolfacilWeb.ConnCase, async: true
  alias TecsolfacilWeb.Api.V1.UserView

  describe "render/2" do
    test "when renderize the token" do
      assert %{token, _} == UserView.render("401.json")
    end

    test "when renderize an error 404" do
      assert %{error: %{detail: "Unauthenticated"}} == UserView.render("401.json")
    end

    test "when renderize an error 400" do
      assert %{error: %{detail: "User not found in body params"}} == UserView.render("400.json")
    end
  end
end
