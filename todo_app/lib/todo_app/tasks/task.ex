defmodule TodoApp.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias TodoApp.Accounts.User

  schema "tasks" do
    field :date, :date
    field :title, :string
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :date, :user_id])
    |> validate_required([:title, :date])
  end
end
