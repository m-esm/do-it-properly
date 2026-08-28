# Bar: CGC-SKIP with an unrecognized route= is illegal

`done = CGC-SKIP whose route= is outside ast-grep|rg|none is dispatch-fail, proven by the skip line; not required: a pack`

`route=` accepts exactly `ast-grep`, `rg`, or `none`. Anything else is rejected,
including tool names that are real search tools, aliases of the two legal ones,
and case or separator variants of them.

```
## Structural discovery
CGC-SKIP: docs-only, no code graph; route=eslint; evidence=characterization-test
```

`dispatch` dies: `CGC-SKIP must include route=ast-grep|rg|none`.

Every one of these was probed against live `dispatch` and rejected identically:
`ack`, `ag`, `ast_grep`, `Ast-Grep`, `AST-GREP`, `astgrep`, `eslint`, `find`,
`grep`, `RG`, `ripgrep`, `ugrep`. The check is an exact string match on the
three legal values, so the list is illustrative, not exhaustive: any other
value fails the same way, and adding a file per value proves nothing new.

Related: `bar-cgc-skip.md` and `bar-cgc-route-none.md` (legal forms),
`bar-cgc-omit-route.md` and `bar-cgc-omit-evidence.md` (the other two illegal forms).
