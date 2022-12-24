defmodule SimpleSubscriptionManager.Logging do

  @doc """
  logディレクトリ内のログをlog_archivに移動させる
  """
  def mv_log() do
    if File.exists? "../log" do
      System.cmd("mkdir", ["../log"])
    end

    if File.exists? "../log/info.log" do
      System.cmd("mv", ["../log/info.log", "../log/log_archiv/`date +%Y年%m月%d日`_info.log"])
    end

    if File.exists? "../log/error.log" do
      System.cmd("mv", ["../log/error.log", "../log/log_archiv/`date +%Y年%m月%d日`_error.log"])
    end

  end

  @doc """
  log_archiv内のログをすべてアーカイブする
  """
  def to_archive() do
    if File.exists? "../log/log_archive" do
      System.cmd("mkdir", ["../log/log_archive"])
    end

    if File.exists? "../log/log_archiv/*_info.log" do
      System.cmd("tar", ["czf", "`date +%Y年%m月`_アクセスログ.tar.gz", "../log/log_archiv/*_info.log", "--remove-files"])
    end

    if File.exists? "../log/log_archiv/*_error.log" do
      System.cmd("tar", ["czf", "`date +%Y年%m月`_エラーログ.tar.gz", "../log/log_archiv/*_error.log", "--remove-files"])
    end
  end

end
