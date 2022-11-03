defmodule SimpleSubscriptionManager.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      SimpleSubscriptionManager.Repo,
      # Start the Telemetry supervisor
      SimpleSubscriptionManagerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SimpleSubscriptionManager.PubSub},
      # Start the Endpoint (http/https)
      SimpleSubscriptionManagerWeb.Endpoint,
      # Start a worker by calling: SimpleSubscriptionManager.Worker.start_link(arg)
      # {SimpleSubscriptionManager.Worker, arg}

      # Quantumタスクスケジューラを開始
      SimpleSubscriptionManager.Scheduler
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SimpleSubscriptionManager.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SimpleSubscriptionManagerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
