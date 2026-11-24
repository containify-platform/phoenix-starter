defmodule PhoenixStarterWeb.Plugs.Health do
  @moduledoc """
  Answers `GET /healthz` with 200 once the app has booted.
  """
  import Plug.Conn

  def init(opts), do: opts

  def call(%Plug.Conn{request_path: "/healthz"} = conn, _opts) do
    conn |> send_resp(200, "ok") |> halt()
  end

  def call(conn, _opts), do: conn
end
