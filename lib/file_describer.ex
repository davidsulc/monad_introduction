defmodule FileDescriber do
  @jpg "jpg"
  @jpg_equiv ["jpg", "jpeg"]

  @mpg "mpg"
  @mpg_equiv ["mpg", "mpeg"]

  def get_extension(filename) do
      filename
      |> String.split(".")
      |> case do
        [_name, ext] -> ext |> Maybe.unit()
        [_name] -> Maybe.nothing()
      end
  end

  def sanitize_extension(ext) when is_binary(ext) do
    ext
    |> String.downcase()
    |> do_sanitize_extension()
  end

  def do_sanitize_extension(ext) when ext in @jpg_equiv, do: @jpg |> Maybe.unit()
  def do_sanitize_extension(ext) when ext in @mpg_equiv, do: @mpg |> Maybe.unit()
  def do_sanitize_extension(_), do: Maybe.nothing()

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
    filename
    |> get_extension()
    |> Maybe.flat_map(&sanitize_extension/1)
    |> Maybe.map(&determine_type/1)
    |> Maybe.map(&format_output/1)
    |> Maybe.it_or_default("File doesn't have valid extension")
  end
end
