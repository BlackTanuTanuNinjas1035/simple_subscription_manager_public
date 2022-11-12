defmodule SimpleSubscriptionManagerWeb.Router do
  use SimpleSubscriptionManagerWeb, :router

  import SimpleSubscriptionManagerWeb.AccountAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SimpleSubscriptionManagerWeb.LayoutView, :root}
    plug :fetch_current_account
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SimpleSubscriptionManagerWeb do
    pipe_through :api

    get "/available-user", ApiController, :index
    get "/service-list", ApiController, :index_service
    get "/genre-list", ApiController, :index_genre
    get "/service-ranking", ApiController, :index_service_ranking
    get "/service-ranking/:gender", ApiController, :index_service_ranking_by_gender
    get "/service-ranking/age/:age", ApiController, :index_service_ranking_by_age
    get "/service-ranking/:gender/:age", ApiController, :index_service_ranking_by_gender_and_age
    get "/genre-ranking", ApiController, :index_genre_ranking
    get "/genre-ranking/:gender", ApiController, :index_genre_ranking_by_gender
    get "/genre-ranking/age/:age", ApiController, :index_genre_ranking_by_age
    get "/genre-ranking/:gender/:age", ApiController, :index_genre_ranking_by_gender_and_age

  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  # if Mix.env() in [:dev, :test] do
  #   import Phoenix.LiveDashboard.Router

  #   scope "/" do
  #     pipe_through :browser

  #     live_dashboard "/dashboard", metrics: SimpleSubscriptionManagerWeb.Telemetry
  #   end
  # end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## 認証(Authen)ルート

  scope "/", SimpleSubscriptionManagerWeb do
    pipe_through [:browser, :redirect_if_account_is_authenticated]

    get "/accounts/register", AccountRegistrationController, :new
    post "/accounts/register", AccountRegistrationController, :create
    get "/accounts/log_in", AccountSessionController, :new
    post "/accounts/log_in", AccountSessionController, :create
    get "/accounts/reset_password", AccountResetPasswordController, :new
    post "/accounts/reset_password", AccountResetPasswordController, :create
    get "/accounts/reset_password/:token", AccountResetPasswordController, :edit
    put "/accounts/reset_password/:token", AccountResetPasswordController, :update
  end

  scope "/", SimpleSubscriptionManagerWeb do
    pipe_through [:browser, :require_authenticated_account]

    get "/accounts/settings", AccountSettingsController, :edit
    put "/accounts/settings", AccountSettingsController, :update
    get "/accounts/settings/confirm_email/:token", AccountSettingsController, :confirm_email
  end

  scope "/", SimpleSubscriptionManagerWeb do
    pipe_through [:browser]

    delete "/accounts/log_out", AccountSessionController, :delete
    get "/accounts/confirm", AccountConfirmationController, :new
    post "/accounts/confirm", AccountConfirmationController, :create
    get "/accounts/confirm/:token", AccountConfirmationController, :edit
    post "/accounts/confirm/:token", AccountConfirmationController, :update
  end

  scope "/", SimpleSubscriptionManagerWeb do
    pipe_through [:browser]

    get "/accounts/delete", AccountQuitController, :index
    get "/accounts/delete/yes", AccountQuitController, :quit
  end

  ## サブスクーラー機能ルート

  scope "/", SimpleSubscriptionManagerWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/help", PageController, :help
    get "/stat", PageController, :stat
  end

  scope "/", SimpleSubscriptionManagerWeb do
    pipe_through [:browser, :require_authenticated_account]

    get "/manager", ManagerController, :index
    post "/manager", ManagerController, :update
    get "/manager/delete/:subscribe_id", ManagerController, :delete
    get "/manager/register", ManagerController, :new
    post "/manager/register", ManagerController, :create
    get "/manager/form", ManagerController, :form
    post "/manager/form", ManagerController, :request_email
  end

  scope "/doc", SimpleSubscriptionManagerWeb do
    pipe_through :browser

    get "/", DocumentController, :index
    get "/:document_id", DocumentController, :show
  end
end
