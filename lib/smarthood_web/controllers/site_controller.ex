defmodule SmarthoodWeb.SiteController do
  use SmarthoodWeb, :controller

  alias Smarthood.Communities
  alias Smarthood.Communities.Site

  def index(conn, _params) do
    sites = Communities.list_sites()
    render(conn, "index.html", sites: sites)
  end

  def new(conn, _params) do
    changeset = Communities.change_site(%Site{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"site" => site_params}) do
    case Communities.create_site(site_params) do
      {:ok, site} ->
        conn
        |> put_flash(:info, "Site created successfully.")
        |> redirect(to: site_path(conn, :show, site))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    site = Communities.get_site!(id)
    render(conn, "show.html", site: site)
  end

  def edit(conn, %{"id" => id}) do
    site = Communities.get_site!(id)
    changeset = Communities.change_site(site)
    render(conn, "edit.html", site: site, changeset: changeset)
  end

  def update(conn, %{"id" => id, "site" => site_params}) do
    site = Communities.get_site!(id)

    case Communities.update_site(site, site_params) do
      {:ok, site} ->
        conn
        |> put_flash(:info, "Site updated successfully.")
        |> redirect(to: site_path(conn, :show, site))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", site: site, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    site = Communities.get_site!(id)
    {:ok, _site} = Communities.delete_site(site)

    conn
    |> put_flash(:info, "Site deleted successfully.")
    |> redirect(to: site_path(conn, :index))
  end
end
