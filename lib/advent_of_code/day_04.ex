defmodule AdventOfCode.Day04 do
  alias AdventOfCode.Utils

  def part1(args) do
    args
    |> Utils.parse_input()
    |> count_valid(&valid_passport?/1)
  end

  def part2(args) do
    args
    |> Utils.parse_input()
    |> count_valid(&strong_valid_passport?/1)
  end

  def count_valid(lines, fun) do
    res =
      Enum.reduce(
        lines,
        %{count: 0, current: %{}},
        fn line, acc -> count_valid_passports(line, acc, fun) end
      )

    res.count + if fun.(res.current), do: 1, else: 0
  end

  def count_valid_passports("", %{count: count, current: current} = acc, fun) do
    inc = if fun.(current), do: 1, else: 0

    acc
    |> Map.update!(:count, &(&1 + inc))
    |> Map.put(:current, %{})
  end

  def count_valid_passports(line, %{count: count, current: current} = acc, _fun) do
    Map.put(acc, :current, parse_line(current, line))
  end

  def valid_passport?(current) do
    result = %{
      data: current,
      errors: %{}
    }

    result =
      result
      |> validate_key("byr", [required()])
      |> validate_key("iyr", [required()])
      |> validate_key("eyr", [required()])
      |> validate_key("hgt", [required()])
      |> validate_key("hcl", [required()])
      |> validate_key("ecl", [required()])
      |> validate_key("pid", [required()])

    Enum.empty?(result.errors)
  end

  def strong_valid_passport?(current) do
    result = %{
      data: current,
      errors: %{}
    }

    result =
      result
      |> validate_key("byr", [required(), date(1920, 2002)])
      |> validate_key("iyr", [required(), date(2010, 2020)])
      |> validate_key("eyr", [required(), date(2020, 2030)])
      |> validate_key("hgt", [required(), hgt()])
      |> validate_key("hcl", [required(), hcl()])
      |> validate_key("ecl", [required(), ecl()])
      |> validate_key("pid", [required(), pid()])

    Enum.empty?(result.errors)
  end

  def required do
    fn
      nil -> {:invalid, "is required"}
      _other -> :ok
    end
  end

  def date(min, max) do
    fn value ->
      cond do
        value == nil ->
          {:invalid, "missing data"}

        String.to_integer(value) >= min && String.to_integer(value) <= max ->
          :ok

        true ->
          {:invalid, "wrong dates"}
      end
    end
  end

  def hgt do
    fn value ->
      if value == nil do
        {:invalid, "missing data"}
      else
        parsed = Regex.named_captures(~r/(?<height>\d+)(?<units>in|cm)/, value)

        if parsed == nil do
          {:invalid, "wrong input"}
        else
          height = String.to_integer(parsed["height"])

          case parsed["units"] do
            "in" ->
              if height >= 59 && height <= 76, do: :ok, else: {:invalid, "Invalid inch"}

            "cm" ->
              if height >= 150 && height <= 193, do: :ok, else: {:invalid, "Invalid cms"}
          end
        end
      end
    end
  end

  def hcl do
    fn value ->
      if value == nil do
        {:invalid, "missing data"}
      else
        case Regex.match?(~r/#[a-f0-9]{6}/, value) do
          true -> :ok
          false -> {:invalid, "Invalid hex"}
        end
      end
    end
  end

  def ecl do
    fn value ->
      if value == nil do
        {:invalid, "missing data"}
      else
        case Enum.member?(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"], value) do
          true -> :ok
          false -> {:invalid, "Invalid eye color"}
        end
      end
    end
  end

  def pid do
    fn value ->
      if value == nil do
        {:invalid, "missing data"}
      else
        case Regex.match?(~r/^[0-9]{9}$/, value) do
          true -> :ok
          false -> {:invalid, "Invalid password id"}
        end
      end
    end
  end

  def validate_key(initial_result, key, validators) do
    value = get_in(initial_result, [:data, key])

    Enum.reduce(validators, initial_result, fn validator, result ->
      case validator.(value) do
        :ok ->
          result

        {:invalid, reason} ->
          update_in(result, [:errors, key], fn
            nil -> [reason]
            other_reasons -> [reason | other_reasons]
          end)
      end
    end)
  end

  def parse_line(current, line) do
    line
    |> String.split(" ")
    |> Enum.reduce(current, fn kv, acc ->
      [key, value] = String.split(kv, ":")
      Map.put(acc, key, value)
    end)
  end
end
