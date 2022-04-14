defmodule Tecsolfacil.Addresses.ReportCsvByEmailTest do
  use ExUnit.Case, async: true
  use Oban.Testing, repo: Tecsolfacil.Repo
  import Swoosh.TestAssertions
  alias Tecsolfacil.Addresses.ReportCsvByEmail
  alias Tecsolfacil.Addresses.BuildReportEmail

  describe "perform/1" do
    test "just perform a simple job" do
      assert {:ok, _} = perform_job(ReportCsvByEmail, %{email: "admin@email.com.br"})
    end
  end
end
