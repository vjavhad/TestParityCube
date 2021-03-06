import UIKit

/// A custom `PagingCell` implementation that only displays a text
/// label. The title is based on the `PagingTitleItem` and the colors
/// are based on the `PagingTheme` passed into `setPagingItem:`. When
/// applying layout attributes it will interpolate between the default
/// and selected text color based on the `progress` property.
open class PagingTitleCell: PagingCell {
  
  fileprivate var viewModel: PagingTitleCellViewModel?
  fileprivate let titleLabel = UILabel(frame: .zero)
  
  open override var isSelected: Bool {
    didSet {
      configureTitleLabel()
    }
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    configure()
  }
  
  open override func setPagingItem(_ pagingItem: PagingItem, selected: Bool, theme: PagingTheme) {
    if let titleItem = pagingItem as? PagingTitleItem {
      viewModel = PagingTitleCellViewModel(
        title: titleItem.title,
        selected: selected,
        theme: theme)
    }
    configureTitleLabel()
  }
  
  open func configure() {
    contentView.addSubview(titleLabel)
  }
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    titleLabel.frame = contentView.bounds
  }
  
  open func configureTitleLabel() {
    guard let viewModel = viewModel else { return }
    titleLabel.text = viewModel.title
    titleLabel.font = viewModel.font
    titleLabel.textAlignment = .center
    
    if viewModel.selected {
      titleLabel.textColor = viewModel.selectedTextColor
      self.backgroundColor = viewModel.selectedBgColor
    } else {
      titleLabel.textColor = viewModel.textColor
      self.backgroundColor = viewModel.BgColor
    }
  }
  
  open override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)
    guard let viewModel = viewModel else { return }
    if let attributes = layoutAttributes as? PagingCellLayoutAttributes {
      titleLabel.textColor = UIColor.interpolate(
        from: viewModel.textColor,
        to: viewModel.selectedTextColor,
        with: attributes.progress)
    }
  }
  
}
