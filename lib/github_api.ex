defmodule GithubApi do
  def exec(request) do
    path = GithubApi.Request.request_path(request)
    query = GithubApi.Request.build_query(request)


    base_url = Application.get_env(:github_api, :api_url)
    http_adapter = Application.get_env(:github_api, :http_adapter)

    url = "#{base_url}#{path}?#{query}"

    {:ok, response} = http_adapter.request(url)

    result = GithubApi.Request.parse_response(request, response)

    {:ok, result}
  end
end

# teste
# developer.github.com
# colaboretor
# fork
# releases

