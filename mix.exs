defmodule Lindel.Mixfile do
  use Mix.Project

  def project do
    [app:     :lindel,
     version: "0.1.0-dev",
     elixir:  "~> 1.4",
     deps:    deps(),

     build_embedded:  Mix.env == :prod,
     start_permanent: Mix.env == :prod]
  end

  def application do
    [extra_applications: [:elastix]]
  end

  defp deps do
    [{ :elastix, "~> 0.4" }]
  end
end
