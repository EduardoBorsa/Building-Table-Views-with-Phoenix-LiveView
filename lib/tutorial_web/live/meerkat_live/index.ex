defmodule TutorialWeb.MeerkatLive.Index do
  use TutorialWeb, :live_view
  alias Tutorial.Meerkats

  def mount(_params, _session, socket), do: {:ok, socket}

  def handle_params(_params, _url, socket) do
    {:noreply, assign_meerkats(socket)}
  end

  defp assign_meerkats(socket) do
    assign(socket, :meerkats, Meerkats.list_meerkats())
  end
end
