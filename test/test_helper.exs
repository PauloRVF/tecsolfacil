ExUnit.start()
ExUnit.configure(trace: true, exclude: :integration)
Ecto.Adapters.SQL.Sandbox.mode(Tecsolfacil.Repo, :auto)
Hammox.defmock(Tecsolfacil.CepWs.Adapters.Mock, for: Tecsolfacil.CepWs.Client)
