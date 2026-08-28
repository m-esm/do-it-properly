# Bar: CGC-SKIP with route=eslint is illegal

`done = CGC-SKIP with route=eslint is dispatch-fail, proven by the skip line; not required: a pack`

This skip is illegal. `route=eslint` is not `ast-grep|rg|none`. `evidence=` is present.

```
## Structural discovery
CGC-SKIP: docs-only, no code graph; route=eslint; evidence=characterization-test
```

`dispatch` dies: `CGC-SKIP must include route=ast-grep|rg|none`.
