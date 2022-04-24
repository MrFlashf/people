defmodule NamesDBTest do
  @moduledoc """
  Integration test that makes sure connection to the 3rd party service is working.
  """
  use ExUnit.Case, async: true

  alias NamesDBImpl, as: SUT

  describe "get_names/0" do
    setup do
      NamesDB.Application.start([], [])

      :ok
    end

    test "returns map with names and surnames" do
      %{
        female_names: female_names,
        female_surnames: female_surnames,
        male_names: male_names,
        male_surnames: male_surnames
      } = SUT.get_names()

      assert length(female_names) == 100
      assert length(male_names) == 100
      assert length(female_surnames) == 100
      assert length(male_surnames) == 100
    end
  end
end
