# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :github_api, :api_url, "https://api.github.com"

config :github_api, :http_adapter, GithubApi.HttpAdapter.GithubAdapter

import_config "#{Mix.env}.exs"