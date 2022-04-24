defmodule PeopleTest do
  use ExUnit.Case
  import Mox

  alias People, as: SUT

  describe "seed_people/2" do
    setup :verify_on_exit!

    setup do
      stub(NamesDBMock, :get_names, fn ->
        %{
          male_names: ["JAN"],
          male_surnames: ["KOWALSKI"],
          female_names: ["ANNA"],
          female_surnames: ["NOWAK"]
        }
      end)

      stub_with(DatabaseMock, DatabaseStub)

      :ok
    end

    test "generates a list of `number_of_people` people" do
      people = SUT.seed_people(100)

      assert length(people) == 100
    end

    test "only generates males, when male proportion is 100" do
      people = SUT.seed_people(100, 100)

      assert people |> Enum.filter(&(&1.sex == :male)) |> length == 100
    end

    test "only generates females, when male proportion is 0" do
      people = SUT.seed_people(100, 0)

      assert people |> Enum.filter(&(&1.sex == :female)) |> length == 100
    end

    test "saves the list into the DB" do
      expect(DatabaseMock, :batch_insert_people, 1, fn people ->
        assert length(people) == 100
      end)

      SUT.seed_people()
    end
  end
end
