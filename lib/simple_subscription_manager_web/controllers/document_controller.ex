defmodule SimpleSubscriptionManagerWeb.DocumentController do
  use SimpleSubscriptionManagerWeb, :controller
  alias SimpleSubscriptionManager.Documents

  def index(conn, _params) do
    document_list = Documents.list_documents
    render(conn, "index.html", document_list: document_list)
  end

  def show(conn, %{"document_id" => document_id}) do
    render(conn, "show.html", document: Documents.get_document(document_id))
  end
end
