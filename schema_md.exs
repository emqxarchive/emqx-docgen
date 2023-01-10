defmodule SchemaMD do
  Code.require_file("md.exs")

  def gen_from_structs(items, opts = %{title: title, body: body}) do
    weight = 2
    [
      title,
      "\n",
      body,
      "\n",
      items
      |> Stream.map(& format_struct(weight, &1, opts))
      |> Enum.intersperse("\n")
    ]
  end

  def format_struct(weight, %{full_name: full_name, paths: paths, fields: fields} = item, opts) do
    [
      MD.h(weight, full_name, %{id: MD.anchor(full_name)}),
      Map.get(item, :desc, ""),
      "\n\n",
      # format_paths(paths),
      # format_envs(paths, opts),
      format_paths_envs_table(paths, opts),
      "\n\n**Fields**\n\n",
      # Enum.map(fields, & format_field(&1, opts)),
      [
        ~s/<ul class="field-list">/,
        "\n",
        Enum.map(fields, &format_field2(&1, opts)),
        "\n",
        ~s{</ul>},
        "\n",
      ]
    ]
  end

  def format_paths_envs_table([], _opts) do
    []
  end
  def format_paths_envs_table(paths, opts) do
    headers = {"Config paths", "Env overrides"}
    paths_envs =
      paths
      |> Stream.map(&MD.code/1)
      |> Enum.zip(Stream.map(paths, fn path ->
           path
           |> format_env(opts)
           |> Enum.join("")
           |> MD.code()
         end))
    MD.table(headers, paths_envs)
  end

  # old formatting
  def format_paths([]), do: []
  def format_paths(paths) do
    [
      "\n**Config paths**\n\n",
      simple_list(paths),
      "\n",
    ]
  end

  def format_envs([], _opts), do: []
  def format_envs(paths, opts) do
    [
      "\n**Env overrides**\n\n",
      paths
      |> Enum.map(&format_env(&1, opts))
      |> simple_list(),
      "\n"
    ]
  end

  def format_env(path, _opts = %{env_prefix: env_prefix}) do
    [env_prefix, path_to_env_name(path)]
  end

  def path_to_env_name(path) do
    path
    |> String.splitter(["."])
    |> Stream.map(&String.upcase/1)
    |> Enum.join("__")
  end

  defmacro if_not_nil(x, code) do
    quote do
      if unquote(x) do
        unquote(code)
      else
        []
      end
    end
  end

  def format_field(field, opts) do
    %{name: name, type: type} = field
    default = format_default(field[:default])
    mapping = format_mapping(field[:mapping])
    desc = Map.get(field, :desc, "")
    [
      [
        "- ",
        name,
        ": ",
        type
        |> type(opts)
        |> MD.code(),
        "\n"
      ],
      if_not_nil(default, [MD.indent(["* default: ", default], 2), "\n\n"]),
      if_not_nil(mapping, [MD.indent(["* mapping: ", mapping], 2), "\n\n"]),
      if_not_nil(desc, [MD.indent([desc], 2), "\n"]),
      "\n"
    ]
  end

  def format_field2(field, opts) do
    %{name: name, type: type} = field
    default = format_default2(field[:default])
    mapping = format_mapping2(field[:mapping])
    desc = Map.get(field, :desc, "")

    lines =
      [
        {strong("Type"), type |> type(opts) |> MD.code()},
        {strong("Default"), default},
        {strong("Mapping"), mapping},
      ]
      |> Enum.filter(& elem(&1, 1))

    [
      "<li>",
      "\n",
      ~s|<h4>#{name}</h4>|,
      "\n",
      # if_not_nil(desc, [MD.indent([desc], 2), "\n\n"]),
      if_not_nil(desc, [desc, "\n\n"]),
      # MD.table(_headers = nil, lines),
      html_table_no_headers(lines),
      "\n",
      "</li>",
      "\n",
    ]
  end

  def strong(text) do
    "<strong>#{text}</strong>"
  end

  def html_table_no_headers(rows) do
    [
      "<table>\n",
      "<tbody>\n",
      Enum.map(rows, fn row ->
        [
          "<tr>",
          row
          |> Tuple.to_list()
          |> Enum.map(fn el ->
            "<td>#{el}</td>"
          end),
          "</tr>",
        ]
      end),
      "</tbody>\n",
      "</table>",
    ]
  end

  def simple_list(xs) do
    xs
    |> Enum.map(&MD.code/1)
    |> MD.ul()
    |> MD.indent(1)
  end

  def format_default(default) do
    with %{oneliner: oneliner?, hocon: content} <- default do
      if oneliner? do
        ["`", content, "`"]
      else
        ["\n```\n", content, "```"]
      end
    end
  end

  def format_default2(default) do
    with %{hocon: content} <- default do
      MD.code(content)
    end
  end

  def format_mapping(mapping) do
    with "" <> text <- mapping do
      ["`", text, "`"]
    end
  end

  def format_mapping2(mapping) do
    with "" <> text <- mapping do
      MD.code(text)
    end
  end

  def type(%{kind: "primitive", name: name}, _opts) do
    name
  end
  def type(%{kind: "singleton", name: name}, _opts) do
    name
  end
  def type(%{kind: "struct", name: ref}, opts) do
    %{
      current_slug: current_slug,
      header_index: header_index,
    } = opts
    ref_slug = Map.fetch!(header_index, ref)
    # if ref_slug == current_slug do
    #   MD.local_link(ref, ref)
    # else
    #   anchor = MD.anchor(ref)
    #   MD.link(ref, "#{ref_slug}.md##{anchor}")
    # end
    anchor = MD.anchor(ref)
    if ref_slug == current_slug do
      ~s|<a href="#{anchor}">#{ref}</a>|
    else
      ~s|<a href="#{ref_slug}.md##{anchor}">#{ref}</a>|
    end
  end
  def type(%{kind: "array", elements: elem_type}, opts) do
    ["[", type(elem_type, opts), "]"]
  end
  def type(%{kind: "union", members: types}, opts) do
    types
    |> Enum.map(&type(&1, opts))
    |> Enum.join(" | ")
  end
  def type(%{kind: "enum", symbols: types}, _opts) do
    Enum.join(types, " | ")
  end
  def type(%{kind: "map", name: name, values: val_type}, opts) do
    ["{$", name, " -> ", type(val_type, opts), "}"]
  end
end
