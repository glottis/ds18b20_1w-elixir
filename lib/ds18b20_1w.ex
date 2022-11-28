defmodule Ds18b201w do
  @moduledoc """
  Documentation for Ds18b201w.
  """

  @doc """
  Lists all connected ds18b201w sensors
  """
  def list_sensors do
    Path.wildcard("/sys/bus/w1/devices/28-*")
  end

  @doc """
  Reads all connected ds18b201w sensors
  """
  def read_sensors do
    list_sensors() |> Enum.map(&read_temperature_file/1)
  end

  @doc """
  Reads and returns sensor file data along with sensor id

  Example:

  iex> Ds18b201w.read_temperature_file("/sys/bus/w1/devices/28-01203d2f1e12")

  {:ok, 28-01203d2f1e12, "01 00 4b 46 7f ff 0c 10 8b : crc=8b YES\n01 00 4b 46 1f ff 0c 10 8b t=62\n"}

  """
  def read_temperature_file(sensor_path) do
    sensor_id = sensor_path |> Path.split() |> List.last()

    case File.read(sensor_path <> "/w1_slave") do
      {:ok, data} -> parse_temperature_file(data, sensor_id)
      {:error, error_msg} -> {:error, sensor_id, error_msg}
    end
  end

  def parse_temperature_file(data, sensor_id \\ "") do
    with true <- valid_crc?(data),
         raw_temp <-
           data
           |> String.split()
           |> Enum.reverse()
           |> List.first()
           |> String.split("=")
           |> List.last()
           |> String.to_integer(),
         temperature <- (raw_temp / 1000) |> Float.round(1) do
      {:ok, sensor_id, temperature}
    else
      _ -> {:error, sensor_id, :invalid_crc}
    end
  end

  defp valid_crc?(crc) do
    crc |> String.split() |> Enum.member?("YES")
  end
end
