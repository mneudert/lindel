defmodule Lindel.Index do
  @moduledoc """
  Lindex Index Definition.
  """

  defmacro __using__(opts) do
    quote do
      @behaviour unquote(__MODULE__)

      @name unquote(opts[:name])
      @url  unquote(opts[:url])

      def name, do: @name
      def url,  do: @url
    end
  end


  @doc """
  Returns the index name.
  """
  @callback name() :: String.t

  @doc """
  Returns the index url.
  """
  @callback url() :: String.t
end
