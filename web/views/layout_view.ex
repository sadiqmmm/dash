defmodule Dash.LayoutView do
  use Dash.Web, :view

  def render_meta(assigns) do
    render_existing(Dash.LayoutView, "meta.html", assigns)
  end

  def page_title(_conn, assigns) do
    case assigns[:post] do
      nil -> I18n.t!("en", "seo.title")
      _ -> assigns[:post].title
    end
  end

  def page_description(_conn, assigns) do
    case assigns[:post] do
      nil -> I18n.t!("en", "seo.description")
      _ -> assigns[:post].summary
    end
  end

  def current_page_url(conn, assigns) do
    path = case assigns[:post] do
      nil -> "/"
      _ -> "/" <> assigns[:post].permalink
    end

    static_url(conn, path)
  end

  def is_admin?(conn) do
    case view_module(conn) do
      Dash.PostView -> true
      _ -> false
    end
  end

  def add_admin_css_class(conn) do
    case is_admin?(conn) do
      true -> "admin"
      _ -> ""
    end
  end
end
