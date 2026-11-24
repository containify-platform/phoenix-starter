defmodule PhoenixStarterWeb.HomeLive do
  use PhoenixStarterWeb, :live_view

  alias PhoenixStarter.Visits

  @impl true
  def mount(_params, _session, socket) do
    # Record the visit once, when the LiveView connects, not on the first
    # (static) render as well.
    visits =
      if connected?(socket) do
        Visits.subscribe()
        Visits.record!("/")
      else
        Visits.count()
      end

    {:ok,
     assign(socket,
       page_title: "Phoenix starter",
       visits: visits,
       database: Visits.database_version()
     )}
  end

  @impl true
  def handle_info({:visits, count}, socket), do: {:noreply, assign(socket, visits: count)}

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="space-y-4">
        <h1 class="text-3xl font-semibold">Phoenix starter</h1>
        <p>
          Phoenix {Application.spec(:phoenix, :vsn)} on Elixir {System.version()}, deployed on
          <a href="https://containify.net" class="link">Containify</a>.
        </p>
        <p>
          This page has been visited <strong id="visits">{@visits}</strong>
          {if @visits == 1, do: "time", else: "times"}. It's a LiveView: open it in another tab
          and watch the count change here.
        </p>
        <p class="text-sm opacity-70">{@database}</p>
        <p>Edit <code>lib/phoenix_starter_web/live/home_live.ex</code> and push to deploy.</p>
      </div>
    </Layouts.app>
    """
  end
end
