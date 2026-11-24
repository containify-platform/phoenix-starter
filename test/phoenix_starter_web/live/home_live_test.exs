defmodule PhoenixStarterWeb.HomeLiveTest do
  use PhoenixStarterWeb.ConnCase

  import Phoenix.LiveViewTest

  test "counts visits", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/")
    assert html =~ "Phoenix starter"
    assert html =~ ~s(<strong id="visits">1</strong>)
  end

  test "answers health checks", %{conn: conn} do
    assert conn |> get("/healthz") |> response(200) == "ok"
  end
end
