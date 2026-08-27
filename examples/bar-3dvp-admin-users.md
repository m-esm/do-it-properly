# Bar: 3dvp admin-users drawer

`done = admin-users drawer + six row actions, proven by verify_admin_users; not required: S1/CAD`

Source: 3dvp [PR #14](https://github.com/m-esm/3d-vibing-platform/pull/14).

The `/admin/users` drawer is list / search / create / set-role / ban / unban (six row actions) plus memberships with last-admin and self guards. Gate: `viewer-next/scripts/verify_admin_users.mjs`.

S1, CAD, impersonation, and SMTP are out of bar.
