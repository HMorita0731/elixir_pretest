defmodule TodoApp.Tasks do
  import Ecto.Query
  alias TodoApp.Repo
  alias TodoApp.Tasks
  alias TodoApp.Tasks.Task

  def list_tasks_by_user(user_id) do
    Task
    |> where([t], t.user_id == ^user_id)
    |> Repo.all()
  end

  def get_task_by_id(id) do
    Task
    |> where([t], t.id == ^id)
    |> Repo.one()
  end

  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end

  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  def update_task(%Task{} = task, attrs) do
    task
    |> change_task(attrs)
    |> Repo.update()
  end

  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end
end
