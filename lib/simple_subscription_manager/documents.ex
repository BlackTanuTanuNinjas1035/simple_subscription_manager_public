defmodule SimpleSubscriptionManager.Documents do
  alias SimpleSubscriptionManager.Documents.Document
  alias SimpleSubscriptionManager.Repo

  @doc """
  apiの一覧を返す
  """
  def list_documents() do
    Repo.all Document
  end

  def get_document!(id), do: Repo.get!(Document, id)

end
