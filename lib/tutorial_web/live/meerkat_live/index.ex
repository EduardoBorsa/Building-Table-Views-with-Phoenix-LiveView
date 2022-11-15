defmodule TutorialWeb.MeerkatLive.Index do
  use TutorialWeb, :live_view
  alias Tutorial.Meerkats
  alias TutorialWeb.Components.SortingComponent
  alias TutorialWeb.Forms.SortingForm

  @impl true
  def mount(_params, _session, socket), do: {:ok, socket}

  @impl true
  def handle_params(params, _url, socket) do
    socket =
      socket
      |> parse_params(params)
      |> assign_meerkats()

    {:noreply, socket}
  end

  @impl true
  def handle_info({:update, opts}, socket) do
    path = Routes.meerkat_index_path(socket, :index, opts)
    {:noreply, push_patch(socket, to: path, replace: true)}
  end

  ############
  # REDUCERS #
  ############

  defp parse_params(socket, params) do
    with {:ok, sorting_opts} <- SortingForm.parse(params) do
      assign_sorting(socket, sorting_opts)
    else
      _error ->
        assign_sorting(socket)
    end
  end

  defp assign_sorting(socket, overrides \\ %{}) do
    opts = Map.merge(SortingForm.default_values(), overrides)
    assign(socket, :sorting, opts)
  end

  defp assign_meerkats(%{assigns: %{sorting: sorting}} = socket) do
    assign(socket, :meerkats, Meerkats.list_meerkats(sorting))
  end
end
