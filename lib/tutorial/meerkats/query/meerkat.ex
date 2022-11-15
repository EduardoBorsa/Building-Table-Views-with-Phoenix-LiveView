defmodule Tutorial.Meerkats.Query.Meerkat do
  import Ecto.Query

  def sort(query, %{sort_by: sort_by, sort_dir: sort_dir})
      when sort_by in [:id, :name] and
             sort_dir in [:asc, :desc] do
    order_by(query, {^sort_dir, ^sort_by})
  end

  def sort(query, _opts), do: query

  def filter(query, opts) do
    query
    |> filter_by_id(opts)
    |> filter_by_name(opts)
  end

  defp filter_by_id(query, %{id: id}) when is_binary(id) and id != "" do
    where(query, [m], m.id == ^id)
  end

  defp filter_by_id(query, _opts) do
    query
  end

  defp filter_by_name(query, %{name: name})
       when is_binary(name) and name != "" do
    query_string = "%#{name}%"
    where(query, [m], ilike(m.name, ^query_string))
  end

  defp filter_by_name(query, _opts), do: query

  def paginate(query, %{page: page, page_size: page_size})
      when is_integer(page) and is_integer(page_size) do
    offset = max(page - 1, 0) * page_size

    query
    |> limit(^page_size)
    |> offset(^offset)
  end

  def paginate(query, _opts), do: query
end
