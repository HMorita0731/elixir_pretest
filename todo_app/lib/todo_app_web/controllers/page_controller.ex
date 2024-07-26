defmodule TodoAppWeb.PageController do
  use TodoAppWeb, :controller

  def home(conn, _params) do
    user = conn.assigns.current_user
    render(conn, :index)
  end
end
