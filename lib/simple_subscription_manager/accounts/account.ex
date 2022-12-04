defmodule SimpleSubscriptionManager.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true, redact: true
    field :hashed_password, :string, redact: true
    field :age, :date
    field :gender, :integer
    field :use_user_info, :boolean
    field :confirmed_at, :naive_datetime

    timestamps()
  end

  @doc """
  A account changeset for registration.

  It is important to validate the length of both email and password.
  Otherwise databases may truncate the email without warnings, which
  could lead to unpredictable or insecure behaviour. Long passwords may
  also be very expensive to hash for certain algorithms.

  ## Options

    * `:hash_password` - Hashes the password so it can be stored securely
      in the database and ensures the password field is cleared to prevent
      leaks in the logs. If password hashing is not needed and clearing the
      password field is not desired (like when using this changeset for
      validations on a LiveView form), this option can be set to `false`.
      Defaults to `true`.
  """
  def registration_changeset(account, attrs, opts \\ []) do
    account
    |> cast(attrs, [:name, :email, :password, :age, :gender, :use_user_info])
    |> validate_name()
    |> validate_email()
    |> validate_password(opts)
    |> validate_required([:use_user_info])
  end

  # 入力されたアカウントの名前の有無、長さを検証する
  defp validate_name(changeset) do
    changeset
    |> validate_required([:name])
    |> validate_length(:name, min: 1, max: 60, message: "最大で60文字の名前(表示名)を設定してください")
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "「＠」がありません。もしくは、スペースが含まれています。")
    |> validate_length(:email, max: 160, message: "160までの文字数で入力してください。")
    |> unsafe_validate_unique(:email, SimpleSubscriptionManager.Repo)
    |> unique_constraint(:email)
  end

  defp validate_password(changeset, opts) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 12, max: 72, message: "12文字から72文字までのパスワードを設定してください")
    # |> validate_format(:password, ~r/[a-z]/, message: "at least one lower case character")
    # |> validate_format(:password, ~r/[A-Z]/, message: "at least one upper case character")
    # |> validate_format(:password, ~r/[!?@#$%^&*_0-9]/, message: "at least one digit or punctuation character")
    |> maybe_hash_password(opts)
  end

  defp maybe_hash_password(changeset, opts) do
    hash_password? = Keyword.get(opts, :hash_password, true)
    password = get_change(changeset, :password)

    if hash_password? && password && changeset.valid? do
      changeset
      # If using Bcrypt, then further validate it is at most 72 bytes long
      |> validate_length(:password, max: 72, count: :bytes)
      |> put_change(:hashed_password, Bcrypt.hash_pwd_salt(password))
      |> delete_change(:password)
    else
      changeset
    end
  end

  @doc """
  A account changeset for changing the email.

  It requires the email to change otherwise an error is added.
  """
  def email_changeset(account, attrs) do
    account
    |> cast(attrs, [:email])
    |> validate_email()
    |> case do
      %{changes: %{email: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :email, "did not change")
    end
  end

  @doc """
  A account changeset for changing the password.

  ## Options

    * `:hash_password` - Hashes the password so it can be stored securely
      in the database and ensures the password field is cleared to prevent
      leaks in the logs. If password hashing is not needed and clearing the
      password field is not desired (like when using this changeset for
      validations on a LiveView form), this option can be set to `false`.
      Defaults to `true`.
  """
  def password_changeset(account, attrs, opts \\ []) do
    account
    |> cast(attrs, [:password])
    |> validate_confirmation(:password, message: "パスワードがマッチしませんでした")
    |> validate_password(opts)
  end

  @doc """
  Confirms the account by setting `confirmed_at`.
  """
  def confirm_changeset(account) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    change(account, confirmed_at: now)
  end

  @doc """
  Verifies the password.

  If there is no account or the account doesn't have a password, we call
  `Bcrypt.no_user_verify/0` to avoid timing attacks.
  """
  def valid_password?(%SimpleSubscriptionManager.Accounts.Account{hashed_password: hashed_password}, password)
      when is_binary(hashed_password) and byte_size(password) > 0 do
    Bcrypt.verify_pass(password, hashed_password)
  end

  def valid_password?(_, _) do
    Bcrypt.no_user_verify()
    false
  end

  @doc """
  Validates the current password otherwise adds an error to the changeset.
  """
  def validate_current_password(changeset, password) do
    if valid_password?(changeset.data, password) do
      changeset
    else
      add_error(changeset, :current_password, "is not valid")
    end
  end

  # 名前の変更が正しいか検証
  def name_changeset(account, attrs) do
    account
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> case do
      %{changes: %{name: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :name, "did not change")
    end
  end

  # 年齢の変更が正しいか検証
  def age_changeset(account, attrs) do
    account
    |> cast(attrs, [:age])
    |> validate_required([:age])
    |> case do
      %{changes: %{age: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :age, "did not change")
    end
  end

  # 性別の変更が正しいか検証
  def gender_changeset(account, attrs) do
    account
    |> cast(attrs, [:gender])
    |> validate_required([:gender])
    |> case do
      %{changes: %{gender: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :gender, "did not change")
    end
  end

  # ユーザ情報の利用の変更が正しいか検証
  def use_user_info_changeset(account, attrs) do
    account
    |> cast(attrs, [:use_user_info])
    |> validate_required([:use_user_info])
    |> case do
      %{changes: %{use_user_info: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :use_user_info, "did not change")
    end
  end

end
