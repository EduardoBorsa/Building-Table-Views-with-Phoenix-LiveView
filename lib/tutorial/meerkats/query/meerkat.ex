defmodule Tutorial.Meerkats.Query.Meerkat do
  import Ecto.Query

  def sort(query, %{sort_by: sort_by, sort_dir: sort_dir})
      when sort_by in [:id, :name] and
             sort_dir in [:asc, :desc] do
    order_by(query, {^sort_dir, ^sort_by})
  end

  def sort(query, _opts), do: query
end
