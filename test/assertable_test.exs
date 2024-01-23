defmodule AssertableTest do
  use ExUnit.Case
  doctest Assertable

  import Assertable

  test "schemas were compiled from config" do
    assert [users: Assertable.User] = Assertable.__schemas__()
  end

  test "sigils were compiled from config" do
    data = [
      %Assertable.User{
        id: "1",
        name: "John Doe",
        age: "42"
      },
      %Assertable.User{
        id: "2",
        name: "Mary Doe",
        age: "42"
      }
    ]

    assert ^data = ~USERS"""
           id,name,age
           1,John Doe,42
           2,Mary Doe,42
           """
  end
end
