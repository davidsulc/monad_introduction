defmodule FileDescriber do
  @jpg "jpg"
  @jpg_equiv ["jpg", "jpeg"]

  @mpg "mpg"
  @mpg_equiv ["mpg", "mpeg"]

  def get_extension(filename) do
    case filename |> String.split(".") do
      [_name, ext] -> {:ok, ext}
      [_] -> :no_extension
    end
  end

  def sanitize_extension(ext) when is_binary(ext) do
    ext
    |> String.downcase()
    |> do_sanitize_extension()
  end

  def do_sanitize_extension(ext) when ext in @jpg_equiv, do: {:ok, @jpg}
  def do_sanitize_extension(ext) when ext in @mpg_equiv, do: {:ok, @mpg}
  def do_sanitize_extension(_), do: {:error, :invalid}

  def determine_type(@jpg), do: "picture"
  def determine_type(@mpg), do: "movie"

  def format_output(type), do: "File is a #{type}"

  @doc ~S"""
      iex> FileDescriber.explain_extension("test.jPg")
      "File is a picture"

      iex> FileDescriber.explain_extension("foo.jpeG")
      "File is a picture"

      iex> FileDescriber.explain_extension("bar.MpeG")
      "File is a movie"

      iex> FileDescriber.explain_extension("foo")
      "File doesn't have valid extension"

      iex> FileDescriber.explain_extension("foo.bar")
      "File doesn't have valid extension"
  """
  def explain_extension(filename) do
    with  {:ok, ext} <- get_extension(filename),
          {:ok, sanitized_ext} <- sanitize_extension(ext),
          type <- determine_type(sanitized_ext) do

      format_output(type)
    else
      _ -> "File doesn't have valid extension"
    end
  end
end
