# Bar: CGC-SKIP with route=ast_grep is illegal

`done = CGC-SKIP with route=ast_grep is dispatch-fail, proven by the skip line; not required: a pack`

This skip is illegal. `route=ast_grep` uses an underscore. It is not `ast-grep|rg|none`. `evidence=` is present.

```
## Structural discovery
CGC-SKIP: docs-only, no code graph; route=ast_grep; evidence=characterization-test
```

`dispatch` dies: `CGC-SKIP must include route=ast-grep|rg|none`.
