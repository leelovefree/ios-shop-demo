# ios-shop-demo

The ShopDemo iOS app (`Sources/`, `Tests/`) — a SwiftUI demo shop used as the first app under test of the
QA team's pipeline. **All QA automation lives in the QA repo** (https://github.com/leelovefree/qa-pipeline,
`apps/shopdemo/`), not here. This repo only builds and ships the app.

How to build and hand builds to QA (simulator builds, releases, accessibility ids): the dev guide in the QA repo,
`docs/huong-dan-dev-ios.md` — https://github.com/leelovefree/qa-pipeline/blob/main/docs/huong-dan-dev-ios.md

- `.github/workflows/release-build.yml` — on every app change to `main`: builds a simulator
  `ShopDemo.app.zip`, publishes it as a GitHub Release (`build-<n>`, marked latest) and, if the
  `QA_DISPATCH_TOKEN` secret is set, notifies the QA repo to test that exact build.
- Keep accessibility identifiers stable (`screen_element_role[_variantId]`, see README) — QA's Maestro flows
  select by them. Renaming one breaks QA tests; tell QA first.
- `.maestro/` — hand-written dev smoke flows (not run in CI; the QA repo owns regression testing).
- Demo account: `demo@shop.com` / `123456`.
