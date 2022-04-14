defmodule Tecsolfacil.Addresses.BuildReportEmail do
  import Swoosh.Email

  def call(dest_email, attachment_path) do
    new()
    |> to({"User", dest_email})
    |> from({"Tecsolfacil Admin", "no-reply@tecsolfacil.com"})
    |> subject("Your requested report")
    |> html_body("<h1>Hello User</h1>")
    |> text_body("your requested CSV report is on attachment")
    |> maybe_add_attachment(attachment_path)
  end

  defp maybe_add_attachment(template, attachment) do
    if File.exists?(attachment) do
      template
      |> attachment(attachment)
    else
      template
    end
  end
end
