# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

ZLCollectionFreePageLayout is a single-file iOS Swift library (CocoaPods) that provides custom page-size snapping for `UICollectionView`. It solves the problem where `isPagingEnabled` fails when the desired page size is smaller than the collection view's frame. Supports both horizontal and vertical scrolling.

## Build & Run

```bash
# Open example project
open ZLCollectionFreePageLayoutExample/ZLCollectionFreePageLayoutExample.xcodeproj

# Validate podspec
pod spec lint ZLCollectionFreePageLayout.podspec

# Run tests (via Xcode)
xcodebuild test -project ZLCollectionFreePageLayoutExample/ZLCollectionFreePageLayoutExample.xcodeproj \
  -scheme ZLCollectionFreePageLayoutExample \
  -destination 'platform=iOS Simulator,name=iPhone 15'
```

No package manager setup needed for development — the library source is a single file with no external dependencies.

## Architecture

The entire library is one class in one file:

- **`ZLCollectionFreePageLayout/ZLCollectionFreePageLayout.swift`** — subclass of `UICollectionViewFlowLayout` that overrides:
  - `collectionViewContentSize` — adjusts content size to account for custom page width so the last page aligns correctly
  - `targetContentOffset(forProposedContentOffset:withScrollingVelocity:)` — implements snap-to-page logic with velocity-based page switching
  - `prepare()` — sets `decelerationRate = .fast`

Key property: `pageWOrH` (page width for horizontal, page height for vertical). When `0`, falls back to standard collection view dimension (equivalent to `isPagingEnabled`).

Content size caching uses `prevContentSize` / `prevCalculatedContentSize` to avoid redundant recalculations.

## Release

- Distributed via CocoaPods (`ZLCollectionFreePageLayout.podspec`)
- Current version: `0.0.8`
- Minimum iOS: 11.0, Swift 5.0
- Tag format: version number matching `spec.version` (e.g., `0.0.8`)
