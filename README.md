# ZLCollectionFreePageLayout

**Custom page size paging for UICollectionView — supports page dimensions smaller than the collection view itself.**

**[中文版](https://github.com/TsinHzl/ZLCollectionFreePageLayout/blob/master/README-zh.md)**

- [Screen Record](#ScreenRecord)
- [Description](#Description)
- [Requirements](#Requirements)
- [Installation](#Installation)
- [Usage](#Usage)
- [API](#API)

#### ScreenRecord

<img src="https://github.com/TsinHzl/ZLCollectionFreePageLayout/assets/9133239/d797c804-9cde-4ff9-b8f9-ca2de9dc5940" alt="screen record" style="zoom:50%;" />

#### Description

- When your desired page size is smaller than the collection view's frame, `UICollectionView.isPagingEnabled` won't work correctly. `ZLCollectionFreePageLayout` solves this with a custom snap-to-page scroll behavior.
- You do **not** need to set `collectionView.isPagingEnabled = true`. Paging is handled automatically by the layout.
- Supports both `.horizontal` and `.vertical` scroll directions.

#### Requirements

| Component | Minimum |
|-----------|---------|
| iOS       | 11.0+   |
| Swift     | 5.0+    |

#### Installation

##### CocoaPods

```ruby
pod 'ZLCollectionFreePageLayout'
# or pin a version:
pod 'ZLCollectionFreePageLayout', '~> 0.0.7'
```

##### Manual

Download or clone the repo, then drag `ZLCollectionFreePageLayout/ZLCollectionFreePageLayout.swift` into your project.

#### Usage

1. Import the module:

```swift
import ZLCollectionFreePageLayout
```

2. Create and configure a `ZLCollectionFreePageLayout` instance, then assign it to your collection view:

```swift
private lazy var collectionView: UICollectionView = {
    let layout = ZLCollectionFreePageLayout()

    // Custom page width (horizontal) or page height (vertical)
    layout.pageWOrH = 200.0
    layout.scrollDirection = .horizontal        // or .vertical
    layout.minimumLineSpacing = 10.0
    layout.minimumInteritemSpacing = 10.0
    layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.showsHorizontalScrollIndicator = false
    return cv
}()
```

3. That's it — no need to set `isPagingEnabled`.

#### API

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `pageWOrH` | `CGFloat` | `0` | Custom page width (horizontal) or height (vertical). `0` falls back to the collection view's own width/height, equivalent to standard `isPagingEnabled`. |
| `scrollDirection` | `UICollectionView.ScrollDirection` | `.vertical` | Inherited from `UICollectionViewFlowLayout`. Determines whether `pageWOrH` controls width or height. |
| `minimumLineSpacing` | `CGFloat` | `10` | Spacing between pages along the scroll direction. |
