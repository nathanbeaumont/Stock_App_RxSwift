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
  let disposeBag = DisposeBag()
  var symbolList: [Symbol]?

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.Custom.lightBlue
    topContainerView.backgroundColor = UIColor.Custom.mediumBlue
    topLabel.configureLabel(fontSize: 22.0)

    setupAddButtonObserver()
    StockListDataBaseManager.shared.getSavedStocks()
  }

  // MARK: Observer Creation Methods
  private func setupAddButtonObserver() {
    addButton.rx.tap
      .subscribe(onNext: { [unowned self] _ in
        if let addStockVC = self.storyboard?.instantiateViewController(withIdentifier: "AddStockViewController") {
          let navController = UINavigationController.navigationControllerForModallyPresented(view: addStockVC)
          self.present(navController, animated: true, completion: nil)
        }
      })
      .disposed(by: disposeBag)
  }
}
