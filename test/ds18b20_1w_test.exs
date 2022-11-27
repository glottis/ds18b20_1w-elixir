defmodule Ds18b201wTest do
  use ExUnit.Case
  doctest Ds18b201w

  test "Check non valid temperature output" do
    assert Ds18b201w.parse_temperature_file(
             "01 00 4b 46 7f ff 0c 10 8b : crc=8b NO 01 00 4b 46 1f ff 0c 10 8b t=62"
           ) ==
             {:error, :invalid_crc}

    assert Ds18b201w.parse_temperature_file(
             "01 00 4b 46 7f ff 0c 11 8b : crc=8f NO 01 00 4b 46 1f ff 0c 10 8b t=62 "
           ) == {:error, :invalid_crc}
  end

  test "Check valid temperature output" do
    assert Ds18b201w.parse_temperature_file(
             "01 00 4b 46 7f ff 0c 10 8b : crc=8b YES 01 00 4b 46 1f ff 0c 10 8b t=10500 "
           ) == {:ok, 10.5}

    assert Ds18b201w.parse_temperature_file(
             "01 00 4b 46 7f ff 0c 11 8b : crc=8f YES 01 00 4b 46 1f ff 0c 10 8b t=-20500 "
           ) == {:ok, -20.5}

    assert Ds18b201w.parse_temperature_file(
             "01 00 4b 46 7f ff 0c 11 8b : crc=8f YES 01 00 4b 46 1f ff 0c 10 8b t=15300"
           ) == {:ok, 15.3}

    assert Ds18b201w.parse_temperature_file(
             "01 00 4b 46 7f ff 0c 11 8b : crc=8f YES 01 00 4b 46 1f ff 0c 10 8b t=8300"
           ) == {:ok, 8.3}

    assert Ds18b201w.parse_temperature_file(
             "01 00 4b 46 7f ff 0c 11 8b : crc=8f YES 01 00 4b 46 1f ff 0c 10 8b t=-1300"
           ) == {:ok, -1.3}
  end
end
