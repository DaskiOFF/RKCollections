import UIKit

open class TableRowSwitch: TableRow<TableSwitchCell> { }

// MARK: - ViewModel
open class TableSwitchCellVM: TableCellVM, Equatable {
    public typealias ChangeActionType = (TableSwitchCellVM) -> Void
    // MARK: Variables
    public var title: String = "" {
        didSet { view?.configure(with: self) }
    }
    fileprivate var _isOn: Bool = false
    public var isOn: Bool {
        get { return _isOn }
        set {
            _isOn = newValue
            view?.configure(with: self)
        }
    }
    public var isEnabled: Bool = true {
        didSet { view?.configure(with: self) }
    }
    public var onTintColor: UIColor? {
        didSet { view?.configure(with: self) }
    }
    public var thumbTintColor: UIColor? {
        didSet { view?.configure(with: self) }
    }
    public var changeAction: ChangeActionType?
    
    // MARK: Init
    public init(title: String, isOn: Bool) {
        self.title = title
        self._isOn = isOn
        super.init(action: nil, userInfo: nil)

        self.isSelectable = false
    }
    
    // MARK: RowHeightComputable
    override open var defaultHeight: CGFloat? {
        return 44
    }
    
    public static func == (lhs: TableSwitchCellVM, rhs: TableSwitchCellVM) -> Bool {
        guard lhs.title == rhs.title else { return false }
        return true
    }
    
    // MARK: Setters
    public func setChangeAction(_ block: TableSwitchCellVM.ChangeActionType?) {
        changeAction = block
    }
}

// MARK: - Cell
open class TableSwitchCell: UITableViewCell, ConfigurableCell {
    public typealias ViewModelType = TableSwitchCellVM
    
    // MARK: Variables
    public var viewModel: TableSwitchCellVM?
    
    // MARK: UI
    let lbTitle: UILabel = UILabel()
    let vwSwitch: UISwitch = UISwitch()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        vwSwitch.isOn = false
        lbTitle.text = nil
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        vwSwitch.frame.origin = CGPoint(x: contentView.frame.width - 16 - vwSwitch.frame.width,
                                        y: (contentView.frame.height - vwSwitch.frame.height) / 2.0)
        
        let textWidth = contentView.frame.width - 32 - 8 - vwSwitch.frame.width
        let textHeight = lbTitle.sizeThatFits(CGSize(width: textWidth, height: contentView.frame.height)).height
        lbTitle.frame = CGRect(x: 16, y: 0, width: textWidth, height: textHeight)
        lbTitle.center.y = contentView.frame.height / 2.0
    }
    
    // MARK: Configure
    private func configure() {
        contentView.addSubview(lbTitle)
        contentView.addSubview(vwSwitch)
        
        vwSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
    }
    
    // MARK: ConfigurableCell
    public func configure(with viewModel: ViewModelType) {
        lbTitle.text = viewModel.title
        vwSwitch.setOn(viewModel.isOn, animated: true)
        vwSwitch.isEnabled = viewModel.isEnabled
        vwSwitch.onTintColor = viewModel.onTintColor
        vwSwitch.thumbTintColor = viewModel.thumbTintColor
    }
    
    // MARK: Actions
    @objc
    private func switchChanged() {
        guard let viewModel = self.viewModel else { return }
        
        viewModel._isOn = vwSwitch.isOn
        viewModel.changeAction?(viewModel)
    }
}
