# Instagram Feed Replica

A polished Flutter recreation of the Instagram home feed with Bloc-driven data flow, shimmer loading states, infinite scrolling, cached remote imagery, and a custom pinch-to-zoom overlay that lifts media above the feed before animating it back into place.

## State Management

This project uses `flutter_bloc` for feed state because it keeps asynchronous loading, pagination, and local post mutations explicit and interview-friendly. The Bloc owns repository fetches and like/save state transitions, while high-frequency visual interaction state such as carousel position and pinch-to-zoom transforms stays inside widgets for smoother rendering and less unnecessary rebuilding.

## Features

- Clean architecture split across `core/` and `features/feed/` with separate models, repositories, services, Bloc, and widgets.
- Mock `PostRepository` with a forced `1.5s` latency to demonstrate a realistic shimmer-first loading experience.
- Infinite scroll that requests the next page when the list builder reaches two posts from the end.
- Cached public network images using `cached_network_image`, including graceful fallback UI for failed image requests.
- Modern Instagram-inspired top bar, stories tray, carousel posts, persistent like/save toggles, and custom snackbars for unimplemented actions.
- System light and dark theme support using extracted Figma spacing/tokens for the light theme and an inferred Instagram-style dark palette.

## Run

```bash
flutter pub get
flutter run
```

## Test

```bash
flutter test
```

## Notes

- Raster post media is intentionally not bundled in `pubspec.yaml`; the feed uses public URLs so caching behavior can be demonstrated realistically.
- Small vector assets such as the Instagram wordmark and verified badge are included under `assets/vectors/`.
