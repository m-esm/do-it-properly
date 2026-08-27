# Bar: illegal CGC-SKIP omits route=

`done = illegal CGC-SKIP with evidence= present and route= missing, proven by the example file; not required: dispatch`

Source: live SSA `dispatch` structural gate (`route=` and `evidence=` both required).

```
## Structural discovery
CGC-SKIP: docs-only, no code graph; evidence=ast-grep -p 'CGC-SKIP:' docs/
```

`evidence=` without `route=ast-grep|rg|none` is illegal. The legal twin is `examples/bar-cgc-skip.md`. Dispatch itself is out of bar.
