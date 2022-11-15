defmodule TutorialWeb.TutorialLive.IndexTest do
  use TutorialWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "Index" do
    test "lists all some_schemas", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.tutorial_index_path(conn, :index))

      assert html =~ "Tutorial Live"
    end
  end
end
