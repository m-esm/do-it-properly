# Bar: CGC-SKIP with route= and no evidence= is illegal

`done = CGC-SKIP with route= present and evidence= missing is dispatch-fail, proven by the skip line; not required: a pack`

This skip is illegal. `route=` is present. `evidence=` is missing.

```
## Structural discovery
CGC-SKIP: docs-only, no code graph; route=none
```

`dispatch` dies: `CGC-SKIP must include evidence=<artifact or literal>`.

Legal form (not this file): `CGC-SKIP: <reason>; route=ast-grep|rg|none; evidence=<artifact or literal>`.
