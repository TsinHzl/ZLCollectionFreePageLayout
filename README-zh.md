# ZLCollectionFreePageLayout
**可以自定义collection view的page size(width/height)分页效果， 尤其是size(width/height)小于collection view的size(width/height)的时候最合适**



- [Screen record](#ScreenRecord)
- [Description](#Description)
- [Installation](#Installation)
- [Usage](#Usage)


#### ScreenRecord
![9f0a668e-b5d8-422d-b3f2-2c3d95bcd232](https://github.com/TsinHzl/ZLCollectionFreePageLayout/assets/9133239/d797c804-9cde-4ff9-b8f9-ca2de9dc5940)

#### Description

-  当出现page size小于collection view的size的时候，可以使用**ZLCollectionFreePageLayout**一下子就实现分页效果
-  并且不需要设置属性**collectionView.isPagingEnabled = true**，只要设置了layout为**ZLCollectionFreePageLayout**,就可以自动实现这种效果



#### Installation

##### cocoapods

- **pod 'ZLCollectionFreePageLayout'**
- 或指定一个版本号:  **pod 'ZLCollectionFreePageLayout', '~> 0.0.7'**

##### 下载 framwork

- 下载代码文件
- 然后 **ZLCollectionFreePageLayout** 到你的项目里即可

#### Usage

- 导入 ZLCollectionLeftAlignLayout

  - ```swift
    import ZLCollectionFreePageLayout
    ```

- set collectionViewLayout of collection view to a instance of ZLCollectionLeftLayout

  - ```swift
    private lazy var collectionView: UICollectionView = {
      // 实例化一个ZLCollectionLeftLayout对象
      let defaultLayout = ZLCollectionFreePageLayout()
      
      // 自定义page width或者page height
      defaultLayout.pageWOrH = 200.0
      defaultLayout.minimumLineSpacing = 10.0
      defaultLayout.minimumInteritemSpacing = 10.0
      defaultLayout.scrollDirection = .vertical
      defaultLayout.sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
      // 设置collection view的layout为ZLCollectionFreePageLayout
      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: defaultLayout)
      collectionView.showsVerticalScrollIndicator = false
      return collectionView
    }()
    ```

- 然后就会自动实现分页效果

- 并且不需要设置属性**collectionView.isPagingEnabled = true**



