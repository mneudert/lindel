defmodule Lindel.Index do
  @moduledoc """
  Lindex Index Definition.
  """

  defmacro __using__(otp_app: otp_app) do
    quote do
      @behaviour unquote(__MODULE__)

      @otp_app unquote(otp_app)

      def config, do: Application.get_env(@otp_app, __MODULE__)
      def name,   do: Keyword.get(config(), :name)
      def url,    do: Keyword.get(config(), :url)

      # generate wrapped modules
      Module.eval_quoted __ENV__, unquote(__MODULE__).inlines(__MODULE__)
      Module.eval_quoted __ENV__, unquote(__MODULE__).submodules(__MODULE__)
    end
  end


  @doc """
  Returns the index configuration.
  """
  @callback config() :: Keyword.t

  @doc """
  Returns the index name.
  """
  @callback name() :: String.t

  @doc """
  Returns the index url.
  """
  @callback url() :: String.t


  @doc """
  Creates inline wrappers around :elastix.
  """
  @spec inlines(module) :: list
  def inlines(index) do
    Enum.map [ Index, Search ], fn (inline) ->
      elastix   = Module.concat(Elastix, inline)
      blacklist = [ :make_path ]

      elastix.__info__(:functions)
      |> Enum.reject(fn ({ name, _arity }) -> Enum.member?(blacklist, name) end)
      |> Enum.map(fn
           { _name, 0 } -> nil
           { _name, 1 } -> nil

           { name, 2 } ->
             quote do
               def unquote(name)() do
                 unquote(elastix).unquote(name)(
                   unquote(index).url(),
                   unquote(index).name()
                 )
               end
             end

           { name, arity } ->
             args = Enum.map(1..(arity - 2), fn (i) -> Macro.var(:"arg_#{i}", __MODULE__) end)

             quote do
               def unquote(name)(unquote_splicing(args)) do
                 unquote(elastix).unquote(name)(
                   unquote(index).url(),
                   unquote(index).name(),
                   unquote_splicing(args)
                 )
               end
             end
         end)
      |> Enum.reject(&( &1 == nil ))
    end
  end

  @doc """
  Creates module wrappers around :elastix.
  """
  @spec submodules(module) :: list
  def submodules(index) do
    Enum.map [ Document, Mapping ], fn (wrap) ->
      elastix   = Module.concat(Elastix, wrap)
      blacklist = [ :get_all, :get_all_with_type, :make_path, :make_all_path ]
      functions =
        elastix.__info__(:functions)
        |> Enum.reject(fn ({ name, _arity }) -> Enum.member?(blacklist, name) end)
        |> Enum.map(fn
             { _name, 0 } -> nil
             { _name, 1 } -> nil

             { name, 2 } ->
               quote do
                 def unquote(name)() do
                   unquote(elastix).unquote(name)(
                     unquote(index).url(),
                     unquote(index).name()
                   )
                 end
               end

             { name, arity } ->
               args = Enum.map(1..(arity - 2), fn (i) -> Macro.var(:"arg_#{i}", __MODULE__) end)

               quote do
                 def unquote(name)(unquote_splicing(args)) do
                   unquote(elastix).unquote(name)(
                     unquote(index).url(),
                     unquote(index).name(),
                     unquote_splicing(args)
                   )
                 end
               end
           end)
        |> Enum.reject(&( &1 == nil ))

      quote do
        defmodule unquote(Module.concat(index, wrap)) do
          unquote(functions)
        end
      end
    end
  end
end
