defmodule Tecsolfacil.Addresses.ReportCsvByEmail do
  use Oban.Worker, queue: :default
  alias Tecsolfacil.Addresses.BuildReportEmail
  alias Tecsolfacil.Addresses.ExportAsCsv

  @moduledoc """
    Obar worker for generate a list of all addresses as CSV and send by email
  """

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"email" => email} = _args}) do
    filename = "report#{get_datetime_string()}.CSV"

    File.write!(filename, ExportAsCsv.call())

    send_status =
      BuildReportEmail.call(email, filename)
      |> Tecsolfacil.Mailer.deliver()

    File.rm!(filename)

    send_status
  end

  def get_datetime_string do
    NaiveDateTime.local_now()
    |> NaiveDateTime.truncate(:second)
    |> NaiveDateTime.to_string()
    |> String.trim()
    |> String.replace("Z", "")
    |> String.replace(~r/[^\d]/, "_")
  end
end
