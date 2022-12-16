#!/usr/bin/env elixir

Mix.install([
  {:hocon, github: "emqx/hocon", ref: "dcddb940ab2af56d6de2015347b6a7eb56948bdb"},
  # {:hocon, path: "../hocon/"},
  :jason
])

lang =
  case OptionParser.parse!(System.argv(), strict: [lang: :string]) do
    {[lang: lang], _} ->
      lang

    _ ->
      Mix.raise("usage: generate-markdown.exs --lang {en,zh}")
  end

unless lang in ["en", "zh"] do
  Mix.raise("Invalid language #{lang}; options are `en`, `zh`")
end

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
    body: File.read!("preamble.#{lang}.md")
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

dist_dir_ce = "dist/emqx/"
dist_dir_ee = "dist/emqx-enterprise/"

[
  {dist_dir_ce, sections_ce},
  {dist_dir_ee, sections_ee}
]
|> Enum.each(fn {dist_dir, sections} ->
  Enum.each(sections, fn %{slug: slug, title: title} = section ->
    body = Map.get(section, :body, "")

    md =
      [dist_dir, "json", "#{slug}.json"]
      |> Path.join()
      |> File.read!()
      |> Jason.decode!(keys: :atoms)
      |> :hocon_schema_md.gen_from_structs(%{title: "# #{title}", body: body, env_prefix: "EMQX_"})

    outfile = Path.join([dist_dir, "md", "#{slug}.md"])
    File.write!(outfile, md)
  end)
end)
