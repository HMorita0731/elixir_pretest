defmodule TodoAppWeb.TaskController do
  use TodoAppWeb, :controller

  alias TodoApp.Accounts.User
  alias TodoApp.Tasks
  alias TodoApp.Tasks.Task

  def list(conn, params) do
    user = TodoApp.Accounts.get_current_user(conn)
    tasks = Tasks.list_tasks_by_user(user.id)

    render(conn, :tasks, tasks: tasks)
  end

  def detail(conn, %{"id" => task_params}) do
    task =
      Tasks.get_task_by_id(task_params)

    render(conn, :detail, task: task)
  end

  def new(conn, _params) do
    cs = Tasks.change_task(%Task{})
    user = TodoApp.Accounts.get_current_user(conn)

    render(conn, :new, changeset: cs, user: user)
  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Created task.")
        |> redirect(to: ~p"/tasks")

      {:error, cs} ->
        render(conn, :new, changeset: cs)
    end
  end

  def edit(conn, %{"id" => task_params}) do
    task = Tasks.get_task_by_id(task_params)
    cs = Tasks.change_task(task)
    render(conn, :edit, task: task, changeset: cs)
  end

  def update(conn, %{"id" => id, "task" => params}) do
    task = Tasks.get_task_by_id(id)

    case Tasks.update_task(task, params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "updated task.")
        |> redirect(to: ~p"/tasks/#{task}")

      {:error, cs} ->
        render(conn, :edit, task: task, changeset: cs)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "deleted task.")
    |> redirect(to: ~p"/tasks")
  end
end
