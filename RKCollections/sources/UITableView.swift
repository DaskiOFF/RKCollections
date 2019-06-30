import UIKit

public extension UITableView {
    func emptyFooter() {
        self.tableFooterView = UIView()
    }
    
    func emptyHeader() {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: CGFloat.leastNonzeroMagnitude, height: CGFloat.leastNonzeroMagnitude)
        self.tableHeaderView = view
    }
}
