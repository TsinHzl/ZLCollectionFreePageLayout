# ZLCollectionFreePageLayout
**You can set custom page size(width/height) especially for the size which is less than the width/height of collection view**



#### Description

-  there is a situation where your page size is less than the size of collection view, and then you can use **ZLCollectionFreePageLayout** to make the paging enabled for the collection view
-  you do not need to set the property **collectionView.isPagingEnabled = true**, it will make paging enabled automatically for the collection view



#### Install

##### cocoapods

- **pod 'ZLCollectionFreePageLayout'**
- or specify a version:  **pod 'ZLCollectionFreePageLayout', '~> 0.0.6'**

##### download framwork

- download the repo.
- and add **ZLCollectionFreePageLayout**  library to your project

#### Usage

- import ZLCollectionLeftAlignLayout

  - ```swift
    import ZLCollectionFreePageLayout
    ```

- set collectionViewLayout of collection view to a instance of ZLCollectionLeftLayout

  - ```swift
    private lazy var collectionView: UICollectionView = {
      // instance ZLCollectionLeftLayout
      let defaultLayout = ZLCollectionFreePageLayout()
      defaultLayout.minimumLineSpacing = 10.0
      defaultLayout.minimumInteritemSpacing = 10.0
      defaultLayout.scrollDirection = .vertical
      defaultLayout.sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 20.0, right: 10.0)
      // set collectionViewLayout to a instance of ZLCollectionFreePageLayout
      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: defaultLayout)
      collectionView.showsVerticalScrollIndicator = false
      return collectionView
    }()
    ```

- and then it will automatically make paging enabled for the collection view

- and you do not need to set the property **collectionView.isPagingEnabled = true**

  
