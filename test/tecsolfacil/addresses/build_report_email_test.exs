defmodule Tecsolfacil.Addresses.BuildReportEmailTest do
  use ExUnit.Case, async: true
  alias Swoosh.Email
  alias Tecsolfacil.Addresses.BuildReportEmail

  describe "call/2" do
    test "mail without attachment" do
      email_template = BuildReportEmail.call("admin@email.com")

      assert %Email{} = email_template
      assert [{_, "admin@email.com"}] = email_template.to
      assert [] = email_template.attachments
    end

    test "mail with attachment" do
      filename = "test_attachment"
      on_exit(fn -> File.rm(filename) end)
      File.write!(filename, "")

      email_template = BuildReportEmail.call("admin@email.com", "test_attachment")

      assert %Email{} = email_template
      assert [{_, "admin@email.com"}] = email_template.to
      assert [%{filename: ^filename}] = email_template.attachments
    end
  end
end
