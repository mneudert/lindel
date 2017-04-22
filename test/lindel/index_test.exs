defmodule Lindel.IndexTest do
  use ExUnit.Case

  alias Lindel.TestHelpers.DummyIndex


  test "definition values exposed" do
    assert "test_name"       == DummyIndex.name
    assert "http://test.url" == DummyIndex.url
  end

  test "wrapper modules defined" do
    assert DummyIndex.Document.__info__(:module)
    assert DummyIndex.Index.__info__(:module)
    assert DummyIndex.Mapping.__info__(:module)
    assert DummyIndex.Search.__info__(:module)
  end
end
