defmodule Lindel.IndexTest do
  use ExUnit.Case

  alias Lindel.TestHelpers.DummyIndex

  test "definition values exposed" do
    assert "test_name" == DummyIndex.name()
    assert "http://test.url" == DummyIndex.url()
  end

  test "inline functions defined" do
    functions = DummyIndex.__info__(:functions)

    assert Enum.any?(functions, fn
             {:exists?, 0} -> true
             _ -> false
           end)

    assert Enum.any?(functions, fn
             {:search, 2} -> true
             _ -> false
           end)
  end

  test "wrapper modules defined" do
    assert DummyIndex.Document.__info__(:module)
    assert DummyIndex.Mapping.__info__(:module)
  end
end
