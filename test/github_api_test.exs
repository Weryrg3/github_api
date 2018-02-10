defmodule GithubApiTest do
  use ExUnit.Case

  test "permite listas os repositórios públicos" do
    assert {:ok, repos} = GithubApi.list_repos()

    assert is_list(repos)
  end

  test "permite listar os repositórios de um usuário" do
    assert {:ok, repos} = GithubApi.list_repos(%{user: "Weryrg3"})
    assert is_list(repos)
  end

  test "permite listar os repositórios de uma organização" do
    assert {:ok, repos} = GithubApi.list_repos(%{org: "elixir-lang"})
    assert is_list(repos)
  end
end
