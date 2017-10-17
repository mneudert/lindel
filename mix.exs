defmodule Lindel.Mixfile do
  use Mix.Project

  @url_github "https://github.com/mneudert/lindel"

  def project do
    [
      app: :lindel,
      version: "0.2.0-dev",
      elixir: "~> 1.4",
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.travis": :test
      ],
      description: "Elastix convenience wrapper thing",
      docs: docs(),
      package: package(),
      test_coverage: [tool: ExCoveralls]
    ]
  end

  def application do
    [extra_applications: [:elastix]]
  end

  defp deps do
    [
      {:elastix, "~> 0.5"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:excoveralls, "~> 0.7", only: :test}
    ]
  end

  defp docs do
    [
      extras: ["CHANGELOG.md", "README.md"],
      main: "readme",
      source_ref: "master",
      source_url: @url_github
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/helpers"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    %{
      files: ["CHANGELOG.md", "LICENSE", "mix.exs", "README.md", "lib"],
      licenses: ["WTFPL 2"],
      links: %{"GitHub" => @url_github},
      maintainers: ["Marc Neudert"]
    }
  end
end
