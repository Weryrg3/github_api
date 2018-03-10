defmodule GithubApi.SearchRepos do
  defstruct params: %{}

  alias GithubApi.SearchRepos

  def init do
    %SearchRepos{}
  end

  def with_term(request, term) do
    put_in(request.params[:term], term)
  end

  def with_user(request, user) do
    put_in(request.params[:user], user)
  end

  def with_org(request, org) do
    put_in(request.params[:org], org)
  end

  def page(request, page) do
    put_in(request.params[:page], page)
  end

  def with_language(request, language) do
    put_in(request.params[:language], language)
  end

  defimpl GithubApi.Request do
    def request_path(_request), do: "/search/repositories"

  def build_query(request) do
    request.params
    |> Enum.reduce(%{q: []}, fn {key, value}, acc ->
      case key do
        :term -> Map.update!(acc, :q, &[value | &1])
        :user -> Map.update!(acc, :q, &["user:#{value}" | &1])
        :org -> Map.update!(acc, :q, &["org:#{value}" | &1])
        :page -> Map.put(acc, :page, value)
        :language -> Map.update!(acc, :q, &["language:#{value}" | &1])
      end
    end)
    |> Map.update!(:q, fn q ->
      Enum.join(q, " ")
    end)
    |> URI.encode_query()
  end

  def parse_response(_request, response) do
    {:ok, decoded} = Poison.decode(response.body) #"Decodifica valor de Jason 'string' para valores corretos"

    %{
      total_count: decoded["total_count"],
      items: decoded["items"]
    }
  end
  end
end
