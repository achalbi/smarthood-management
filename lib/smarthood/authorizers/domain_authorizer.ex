defmodule Smarthood.Plugs.DomainAuthorizer do
	import Plug.Conn

	alias Smarthood.Organizations

	@actions [:new, :edit, :delete]

  def init(default), do: default

  def call(%Plug.Conn{:private => %{:phoenix_action => action, :phoenix_controller => SmarthoodWeb.DomainController}} = conn, _default) when action in @actions do
		organization = hd(conn.assigns.current_user.organizations)
		if Organizations.is_org_moderator?(conn.assigns.current_user.id, organization.id) do
			assign(conn, :authorized, true)
		else
			assign(conn, :authorized, false)
			Smarthood.Plugs.Authorizer.unauthorized_user(conn)
		end
	end

	def call(conn, _default), do: conn
end