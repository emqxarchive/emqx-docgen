defmodule MD do
  def h(weight, text, opts \\ %{}) do
    id = opts[:id]
    id_tag = if id, do: "<a id='#{id}'></a>"
    markup = String.duplicate("#", weight)

    "#{markup} #{text} #{id_tag}\n"
  end

  def h1(txt), do: h(1, txt)
  def h2(txt), do: h(2, txt)
  def h3(txt), do: h(3, txt)
  def h4(txt), do: h(4, txt)
  def h5(txt), do: h(5, txt)
  def h6(txt), do: h(6, txt)

  def link(text, path), do: "[#{text}](#{path})"
  def local_link(text, ref), do: link(text, "#" <> anchor(ref))
  def ul(items) do
    Enum.map(items, & "- #{&1}\n")
  end

  def anchor(header_title) do
    %{
      ~r/\./ => "",
      ~r/'/ => "",
      ~r/:/ => "-",
      ~r/\s/ => "-",
    }
    |> Enum.reduce(String.downcase(header_title), fn {find, replace}, acc ->
      String.replace(acc, find, replace)
    end)
  end

  def code(text), do: "<code>#{text}</code>"

  def indent(lines, n) do
    padding = String.duplicate(" ", n)

    lines
    |> Stream.intersperse("\n")
    |> Enum.join("")
    |> String.splitter(["\n"])
    |> Stream.map(fn line ->
      if line != "" do
        [padding, line]
      else
        ""
      end
    end)
    |> Stream.reject(& &1 == "")
    |> Enum.intersperse("\n")
  end
end
