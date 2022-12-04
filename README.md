# EMQX's document generation

This repo is to hold the generated schema artificats which are used as
the source for documentation rendering.

## Background

The main user interfaces to configure and manage EMQX are

- HTTP API (and on top of it, the web-based dashboard)
- Configuration files
- Command line interface

Starting from version 5, HTTP API and Configuration are developed with
a unified schema to avoid repeating ourselves in:

- Input validation and translation
- Objects and fields documentation

## What is this repo for

For documentation, since the underlying schema is shared,
it is possible to auto-generate them.
E.g. the types and descriptions of the objects and fileds.

However, there are certain parts of the doucment that
are not possible to aut-generate. For example the
lengthy in-general description to explain how the different
configuration system works.

This repo, is created as an intermediate stop to hold the
generated artifacts which includes:

- The JSON representation of the schema.
- The hand-crafted document contents, i.e. the parts of the document which do not make sense
  to be a part of [emqx.git](https://github.com/emqx/emqx.git)
- The final markdown generation scripts.
  For as long as the [docs site](https://github.com/emqx/emqx-docs)
  is rendering the doc pages from markdown, we will continue to generate markdown.

In general this is the (second-stop) source of truth for
downstream document generation or rendering. Meaning it is not a replacement for
[emqx-docs.git](https://github.com/emqx/emqx-docs) but the input of it.

## Why isn't this made a part of [emqx-docs.git](https://github.com/emqx/emqx-docs).

The doc repo [emqx-docs.git](https://github.com/emqx/emqx-docs) holds the raw
material (most of which is hand-crafted markdown) for only on purpose: doc-site rendering.

This repo however, can hold the source of multiple downtreams, to name a few:

- EMQX configuration docs markdown generation.
- Multi-language translations (i18n).
  So far we only supprot 2 languages, the translations still in [emqx.git](https://github.com/emqx/emqx.git).
  In future release, we'll keep only the english descriptions in the source code and move translations here.
- The OpenAPI 3.0 specification.
- With the canonical schema format (JSON) version controlled here, a future doc-rendering web server
  can make use of this source to render the pages in a whole different way.
