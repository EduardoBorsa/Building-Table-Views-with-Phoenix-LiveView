defmodule TutorialWeb.MeerkatLive.Index do
  use TutorialWeb, :live_view
  alias Tutorial.Meerkats
  alias TutorialWeb.Components.SortingComponent
  alias TutorialWeb.Forms.SortingForm
  alias TutorialWeb.Forms.FilterForm

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
    params = merge_and_sanitize_params(socket, opts)
    path = Routes.meerkat_index_path(socket, :index, params)
    {:noreply, push_patch(socket, to: path, replace: true)}
  end

  ############
  # REDUCERS #
  ############

  defp parse_params(socket, params) do
    with {:ok, sorting_opts} <- SortingForm.parse(params),
         {:ok, filter_opts} <- FilterForm.parse(params) do
      socket
      |> assign_filter(filter_opts)
      |> assign_sorting(sorting_opts)
    else
      _error ->
        socket
        |> assign_sorting()
        |> assign_filter()
    end
  end

  defp assign_sorting(socket, overrides \\ %{}) do
    opts = Map.merge(SortingForm.default_values(), overrides)
    assign(socket, :sorting, opts)
  end

  defp assign_filter(socket, overrides \\ %{}) do
    assign(socket, :filter, FilterForm.default_values(overrides))
  end

  defp assign_meerkats(socket) do
    params = merge_and_sanitize_params(socket)
    assign(socket, :meerkats, Meerkats.list_meerkats(params))
  end

  #####################
  # PRIVATE FUNCTIONS #
  #####################

  defp merge_and_sanitize_params(
         %{
           assigns: %{
             sorting: sorting,
             filter: filter
           }
         },
         overrides \\ %{}
       ) do
    %{}
    |> Map.merge(sorting)
    |> Map.merge(filter)
    |> Map.merge(overrides)
    |> Enum.reject(fn {_key, value} -> is_nil(value) end)
    |> Map.new()
  end
end
