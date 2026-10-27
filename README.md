# iOS Shop Demo

A native SwiftUI fashion-shop app built purely as a **Maestro QA automation target**. It has no backend — login and checkout are intentionally hardcoded/simulated so that automation flows are fast, deterministic, and reproducible on every run.

## Prerequisites

- Xcode 16+ (tested with Xcode 26.6)
- [XcodeGen](https://github.com/yonaskolb/XcodeGen): `brew install xcodegen`
- [Maestro](https://maestro.mobile.dev) CLI installed separately, for running the automation flows in `.maestro/`

## Generate the project

```bash
cd ios-shop-demo
xcodegen generate
```

This creates `ShopDemo.xcodeproj` from `project.yml` (the `.xcodeproj` is not committed to git — regenerate it any time with the command above).

## Open & run

```bash
open ShopDemo.xcodeproj
```

Select an iPhone simulator and hit **Cmd+R**.

## Demo credentials

```
Email:    demo@shop.com
Password: 123456
```

Any other combination shows an inline error and does not log in.

## Project structure

```
Sources/
├── App/            # @main entry point, root navigation switch
├── DesignSystem/    # colors, fonts, metrics, shared button/card styles
├── Models/          # Product, CartItem, Route
├── Stores/          # AuthStore, CartStore, FavoritesStore (@Observable), ProductCatalog (mock data)
├── Views/           # Login, Home, ProductDetail, Favorites, Cart, Checkout, OrderConfirmation, Shared
└── Resources/        # Assets.xcassets
Tests/ShopDemoTests/  # cart logic smoke tests (Swift Testing)
.maestro/             # ready-to-run Maestro flows
```

## Accessibility identifier convention

Every interactive or assertable element follows `screen_element_role[_variantId]`, e.g. `login_email_field`, `home_product_item_defile-lux-blazer`, `cart_item_qty_increment_button_<cartItemId>`. Keep new elements consistent with this pattern so Maestro flows stay easy to write.

## Running the Maestro flows

With a simulator booted and the app installed (build & run once from Xcode first):

```bash
maestro test .maestro/login_success.yaml
maestro test .maestro/login_failure.yaml
maestro test .maestro/browse_add_to_cart.yaml
maestro test .maestro/checkout_happy_path.yaml

# or run all of them:
maestro test .maestro/
```

## Home search, sort and favorites

- **Search & sort** (Home): `home_search_field` filters by product name (case-insensitive, combines with the category chips); `home_sort_button` opens a menu with `home_sort_option_<default|price-asc|price-desc|name-asc>`. No match shows `home_empty_state_label`.
- **Favorites**: heart on each Home card (`home_product_favorite_button_<productId>`) and on Product Detail (`product_detail_favorite_button`) share one state. `home_favorites_button` opens the Favorites screen (`favorites_screen`) listing `favorites_item_<productId>` with `favorites_remove_button_<productId>`; empty list shows `favorites_empty_state_label`.

## Known limitations

- No persistence — session, cart and favorites always reset on relaunch.
- Checkout is fully simulated: a ~1.5s delay generates a fake order ID, no real payment.
- Product photos are SF Symbol placeholders on tinted backgrounds, not real images.
