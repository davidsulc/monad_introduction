defmodule FileDescriber do
  @jpg "jpg"
  @jpg_equiv ["jpg", "jpeg"]

  @mpg "mpg"
  @mpg_equiv ["mpg", "mpeg"]

  def get_extension(filename) do
    [_name, ext] = filename |> String.split(".")
    ext
  end

  def sanitize_extension(ext) when is_binary(ext) do
    ext
    |> String.downcase()
    |> do_sanitize_extension()
  end

  def do_sanitize_extension(ext) when ext in @jpg_equiv, do: @jpg
  def do_sanitize_extension(ext) when ext in @mpg_equiv, do: @mpg

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
  """
  def explain_extension(filename) do
    filename
    |> get_extension()
    |> sanitize_extension()
    |> determine_type()
    |> format_output()
  end
end
