defmodule Smarthood.StatusTrack.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smarthood.StatusTrack.Comment
  alias Smarthood.StatusTrack.WorkStatus
  alias Smarthood.Accounts.User


  schema "comments" do
    field :content, :string
    belongs_to :work_status, WorkStatus
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:content, :user_id, :work_status_id])
    |> validate_required([:content])
  end
end
