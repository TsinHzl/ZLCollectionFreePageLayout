# ZLCollectionFreePageLayout

**自定义 UICollectionView 分页尺寸 —— 支持页面尺寸小于 collection view 自身尺寸的分页效果。**

**[English](https://github.com/TsinHzl/ZLCollectionFreePageLayout/blob/master/README.md)**

- [效果预览](#ScreenRecord)
- [说明](#Description)
- [环境要求](#Requirements)
- [安装](#Installation)
- [使用方法](#Usage)
- [API 说明](#API)

#### ScreenRecord

<img src="https://github.com/TsinHzl/ZLCollectionFreePageLayout/assets/9133239/d797c804-9cde-4ff9-b8f9-ca2de9dc5940" alt="screen record" style="zoom:50%;" />

#### Description

- 当页面尺寸小于 collection view 的 frame 时，系统的 `isPagingEnabled` 无法正常工作。`ZLCollectionFreePageLayout` 通过自定义滚动吸附（snap-to-page）逻辑解决了这个问题。
- **无需设置** `collectionView.isPagingEnabled = true`，将 layout 设置为 `ZLCollectionFreePageLayout` 即可自动实现分页效果。
- 支持 `.horizontal` 和 `.vertical` 两种滚动方向。

#### Requirements

| 组件  | 最低版本 |
|-------|---------|
| iOS   | 11.0+   |
| Swift | 5.0+    |

#### Installation

##### CocoaPods

```ruby
pod 'ZLCollectionFreePageLayout'
# 或指定版本：
pod 'ZLCollectionFreePageLayout', '~> 0.0.7'
```

##### 手动集成

下载或克隆本仓库，将 `ZLCollectionFreePageLayout/ZLCollectionFreePageLayout.swift` 拖入你的项目即可。

#### Usage

1. 导入模块：

```swift
import ZLCollectionFreePageLayout
```

2. 创建并配置 `ZLCollectionFreePageLayout` 实例，然后设置给 collection view：

```swift
private lazy var collectionView: UICollectionView = {
    let layout = ZLCollectionFreePageLayout()

    // 自定义 page width（水平滚动）或 page height（垂直滚动）
    layout.pageWOrH = 200.0
    layout.scrollDirection = .horizontal        // 或 .vertical
    layout.minimumLineSpacing = 10.0
    layout.minimumInteritemSpacing = 10.0
    layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.showsHorizontalScrollIndicator = false
    return cv
}()
```

3. 完成 —— 无需设置 `isPagingEnabled`。

#### API

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `pageWOrH` | `CGFloat` | `0` | 自定义页面宽度（水平滚动）或高度（垂直滚动）。`0` 表示使用 collection view 的宽/高，效果等同于系统的 `isPagingEnabled`。 |
| `scrollDirection` | `UICollectionView.ScrollDirection` | `.vertical` | 继承自 `UICollectionViewFlowLayout`，决定 `pageWOrH` 控制的是宽度还是高度。 |
| `minimumLineSpacing` | `CGFloat` | `10` | 滚动方向上各页面之间的间距。 |
