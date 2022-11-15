defmodule Tutorial.Meerkats.Meerkat do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "meerkats" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(meerkat, attrs) do
    meerkat
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
