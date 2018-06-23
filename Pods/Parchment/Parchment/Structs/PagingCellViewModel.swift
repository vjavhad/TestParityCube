import Foundation

struct PagingTitleCellViewModel {
  
  let title: String?
  let font: UIFont
  let textColor: UIColor
  let selectedTextColor: UIColor
    let selectedBgColor: UIColor
    let BgColor: UIColor
  let selected: Bool
  
  init(title: String?, selected: Bool, theme: PagingTheme) {
    self.title = title
    self.font = theme.font
    self.textColor = theme.textColor
    self.BgColor = theme.backgroundColor
    self.selectedTextColor = theme.selectedTextColor
    self.selectedBgColor = theme.selectedBackgroundColor
    self.selected = selected
  }
  
}
