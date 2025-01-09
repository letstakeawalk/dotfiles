- List installed formulae that are not dependencies of another installed formula:

`brew leaves [-r, --installed-on-request] [-p, --installed-as-dependency]`  

- Show dependencies for formula:

`brew deps [options] [formula|cask]` | `brewdeps`

- Uninstall dependency formulae of another formula and are now no longer needed:

`brew autoremove [--dry-run]`

- Remove stale lock files, outdated downloads, old versions of installed formulae.

`brew cleanup [--dry-run]`

- Shortcuts

`brewleaves - List leaves and formulae which depends on the leaf`
`brewdeps - List formalue and its dependencies`
`brewlist - List formalae installed on request`
