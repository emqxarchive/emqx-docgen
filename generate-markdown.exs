#!/usr/bin/env elixir

Mix.install([
  {:hocon, github: "emqx/hocon", ref: "dcddb940ab2af56d6de2015347b6a7eb56948bdb"},
  # {:hocon, path: "../hocon/"},
  :jason
])

defmodule Main do
  Code.require_file("md.exs")
  Code.require_file("schema_md.exs")

  def parse_args!(args) do
    lang =
      case OptionParser.parse!(args, strict: [lang: :string]) do
        {[lang: lang], _} ->
          lang

        _ ->
          Mix.raise("usage: generate-markdown.exs --lang {en,zh}")
      end

    unless lang in ["en", "zh"] do
      Mix.raise("Invalid language #{lang}; options are `en`, `zh`")
    end

    %{lang: lang}
  end

  def sections() do
    generic_section = [
      %{
        slug: "others",
        title: "Other Configurations"
      }
    ]

    common_sections = [
      %{
        slug: "emqx",
        title: "EMQX",
      },
      %{
        slug: "authn",
        title: "Authentication"
      },
      %{
        slug: "authz",
        title: "Authorization"
      },
      %{
        slug: "bridges",
        title: "Bridges"
      },
      %{
        slug: "rule",
        title: "Rule Engine"
      },
      %{
        slug: "gateway",
        title: "Gateways"
      }
    ]

    sections_ce = common_sections ++ generic_section

    sections_ee =
      common_sections ++
      [
        %{
          slug: "gateway",
          title: "Gateways"
        }
      ] ++ generic_section

    %{
      sections_ce: sections_ce,
      sections_ee: sections_ee,
    }
  end

  def make_index(sections, lang) do
    preamble = File.read!("preamble.#{lang}.md")
    entries =
      sections
      |> Enum.map(fn %{slug: slug, title: title} ->
        MD.link(title, "./#{slug}.md")
      end)
      |> MD.ul()

    """
    #{preamble}

    # Sections

    #{entries}
    """
  end

  def generate_markdown(opts) do
    dist_dir_ce = "dist/emqx/"
    dist_dir_ee = "dist/emqx-enterprise/"
    %{lang: lang} = opts
    %{
      sections_ce: sections_ce,
      sections_ee: sections_ee,
    } = sections()

    [
      {dist_dir_ce, sections_ce},
      {dist_dir_ee, sections_ee}
    ]
    |> Enum.each(fn {dist_dir, sections} ->
      Enum.each(sections, fn %{slug: slug, title: title} = section ->
        index = make_index(sections, lang)
        outfile = Path.join([dist_dir, "md", "index.md"])
        File.write!(outfile, index)

        body = Map.get(section, :body, "")

        md =
          [dist_dir, "json", "#{slug}.json"]
          |> Path.join()
          |> File.read!()
          |> Jason.decode!(keys: :atoms)
          |> SchemaMD.gen_from_structs(%{title: "# #{title}", body: body, env_prefix: "EMQX_"})

        outfile = Path.join([dist_dir, "md", "#{slug}.md"])
        File.write!(outfile, md)
      end)
    end)
  end

  def main() do
    System.argv()
    |> parse_args!()
    |> generate_markdown()
  end
end

Main.main()
