ExUnit.start()
ExUnit.configure(trace: true)
Ecto.Adapters.SQL.Sandbox.mode(Tecsolfacil.Repo, :manual)
Hammox.defmock(Tecsolfacil.CepWs.Adapters.Mock, for: Tecsolfacil.CepWs.Client)
