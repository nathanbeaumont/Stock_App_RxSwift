import RxCocoa
import RxSwift
import UIKit

class StockListViewController: UIViewController {

  // MARK: Outlets
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var topContainerView: UIView!
  @IBOutlet weak var topLabel: UILabel!


  // MARK: Stored Properties
  private let stockCellIdentifier = String(describing: TrackedStockCell.self)
  private var stockListDataSource: PublishSubject<Array<Stock>> = PublishSubject.init()
  private let disposeBag = DisposeBag()
  private var symbolList: [Stock] = []
  private var stockListSubject: StockListSubject?

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.Custom.lightBlue
    topContainerView.backgroundColor = UIColor.Custom.mediumBlue
    topLabel.configureLabel(fontSize: 22.0)

    setupAddButtonObserver()
    setupTableView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    setupDataSourceObserver()
  }

  func setupDataSourceObserver() {
    symbolList = []
    stockListSubject = StockListSubject(stockList: StockListDataBaseManager.shared.getSavedStocks())
    stockListSubject?.publishSubject
      .subscribe(onNext: { [weak self] stock in
        self?.symbolList.append(stock)
        self?.symbolList.sort(by: { $0.symbol < $1.symbol })
        self?.stockListDataSource.onNext(self?.symbolList ?? [])
      })
      .disposed(by: disposeBag)
  }

  // MARK: Observer Creation Methods
  private func setupAddButtonObserver() {
    addButton.rx
      .tap
      .subscribe(onNext: { [unowned self] _ in
        if let addStockVC = self.storyboard?.instantiateViewController(withIdentifier: "AddStockViewController") {
          let navController = UINavigationController.navigationControllerForModallyPresented(view: addStockVC)
          self.present(navController, animated: true, completion: nil)
        }
      })
      .disposed(by: disposeBag)
  }

  // MARK: TablieView DataSource & Delegate Observers

  private func setupTableView() {
    tableView.allowsSelection = false
    tableView.dataSource = nil
    tableView.delegate = self
    tableView.tableFooterView = UIView()
    stockListDataSource
      .bind(to: tableView.rx.items(cellIdentifier: stockCellIdentifier)) { index, model, cell in
        guard let cell = cell as? TrackedStockCell else {
          return
        }

        cell.configureStockCell(stock: model)
      }
      .disposed(by: disposeBag)
  }
}

extension StockListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120.0
  }
}
