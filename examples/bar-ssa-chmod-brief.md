# Bar: chmod-only brief.md is fail; missing-brief is not

`done = chmod-000 brief.md is verify-fail, missing-brief ENOENT is pass, proven by hermetic verify; not required: worker`

Source: Discord #smart-subagents 2026-08-27 12:47 UTC (`1542515896692506626`).

```
fixture=chmod-only
CGC-SKIP: fixture; route=none; evidence=characterization-test
brief.md present mode=000
EACCES: permission denied, open '$DIR/brief.md'
verify: verdict=fail new_failures=0 scope_ok=None secrets_ok=True changed=0
exit=1
changed_files=0
empty tree + chmod EACCES is fail; missing-brief ENOENT is not
```

chmod-only (`brief.md` present, mode 000, EACCES) is fail. Missing `brief.md` (ENOENT) is not.
