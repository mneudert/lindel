defmodule Lindel.IndexTest do
  use ExUnit.Case

  defmodule Dummy do
    use Lindel.Index, [ name: "test_name", url: "http://test.url" ]
  end

  test "definition values exposed" do
    assert "test_name"       == Dummy.name
    assert "http://test.url" == Dummy.url
  end
end
