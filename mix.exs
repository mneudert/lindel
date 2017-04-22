defmodule Lindel.Mixfile do
  use Mix.Project

  def project do
    [app:     :lindel,
     version: "0.1.0-dev",
     elixir:  "~> 1.4",
     deps:    deps(),

     elixirc_paths:   elixirc_paths(Mix.env),
     build_embedded:  Mix.env == :prod,
     start_permanent: Mix.env == :prod,

     preferred_cli_env: [
       coveralls:          :test,
       'coveralls.detail': :test,
       'coveralls.travis': :test
     ],

     test_coverage: [ tool: ExCoveralls ]]
  end

  def application do
    [extra_applications: [:elastix]]
  end

  defp deps do
    [{ :excoveralls, "~> 0.6", only: :test },

     { :elastix, "~> 0.4" }]
  end

  defp elixirc_paths(:test), do: [ "lib", "test/helpers" ]
  defp elixirc_paths(_),     do: [ "lib" ]
end
