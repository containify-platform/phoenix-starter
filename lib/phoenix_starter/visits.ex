defmodule PhoenixStarter.Visits do
  @moduledoc """
  Counts visits to the home page, kept in Postgres. Each new visit is
  broadcast, so every open page updates live.
  """
  import Ecto.Query
  alias PhoenixStarter.Repo

  defmodule Visit do
    use Ecto.Schema

    schema "visits" do
      field :path, :string
      timestamps(type: :utc_datetime)
    end
  end

  @topic "visits"

  def subscribe, do: Phoenix.PubSub.subscribe(PhoenixStarter.PubSub, @topic)

  def record!(path) do
    Repo.insert!(%Visit{path: path})
    count = count()
    Phoenix.PubSub.broadcast(PhoenixStarter.PubSub, @topic, {:visits, count})
    count
  end

  def count, do: Repo.aggregate(from(v in Visit), :count)

  def database_version, do: Repo.query!("select version()").rows |> hd() |> hd()
end
