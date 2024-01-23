defmodule Assertable do
  @schemas Application.compile_env!(:assertable, :schemas)

  alias NimbleCSV.RFC4180, as: CSV

  @doc false
  def __schemas__, do: @schemas

  for {name, schema} <- @schemas do
    name = "sigil_#{String.upcase(to_string(name))}"

    def unquote(String.to_atom(name))(string, opts) do
      Assertable.parse_tabular(string, unquote(schema), opts)
    end
  end

  @doc false
  def parse_tabular(string, schema, _opts) do
    fields = apply(schema, :__schema__, [:fields])

    for row <- CSV.parse_string(string) do
      struct!(schema, Map.new(Enum.zip(fields, row)))
    end
  end
end
