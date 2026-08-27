# Bar: illegal CGC-SKIP route=ag

`done = illegal CGC-SKIP with route=ag (not ast-grep|rg|none) is dispatch-fail, proven by the skip line; not required: a pack`

This skip is illegal. `route=` and `evidence=` are present. `route=ag` is not an allowed value.

```
## Structural discovery
CGC-SKIP: docs-only, no code graph; route=ag; evidence=ast-grep -p 'CGC-SKIP:' docs/
```

`dispatch` dies: `CGC-SKIP must include route=ast-grep|rg|none`.

Legal form (not this file): `CGC-SKIP: <reason>; route=ast-grep|rg|none; evidence=<artifact or literal>`. The legal twin is `examples/bar-cgc-skip.md`.
