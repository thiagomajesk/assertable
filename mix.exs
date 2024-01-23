defmodule Assertable.MixProject do
  use Mix.Project

  def project do
    [
      app: :assertable,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:nimble_csv, "~> 1.1"}
    ]
  end
end
