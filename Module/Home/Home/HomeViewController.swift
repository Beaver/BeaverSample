import Beaver
import Core

final class HomeViewController: ViewController<HomeState, AppState> {
    lazy fileprivate var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame)
        tableView.delegate = self.dataSource
        tableView.dataSource = self.dataSource
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    fileprivate lazy var dataSource: HomeViewControllerDataSource = {
        let dataSource = HomeViewControllerDataSource()
        dataSource.weakController = self
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dispatch(action: HomeUIAction.didViewAppear)
    }
    
    override func stateDidUpdate(oldState: HomeState?,
                                 newState: HomeState,
                                 completion: @escaping () -> ()) {
        if oldState != newState {
            tableView.reloadData()
        }
        completion()
    }
}

private final class HomeViewControllerDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    weak var weakController: HomeViewController?
    
    var controller: HomeViewController {
        guard let controller = weakController else {
            fatalError("HomeViewController has been released to soon")
        }
        return controller
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.state.movies?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = controller.state.movies?[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movies = controller.state.movies else {
            fatalError("Can't select a movie if state doens't have any movie")
        }
        
        let movie = movies[indexPath.row]
        
        controller.dispatch(action: HomeUIAction.didTapOnMovieCell(id: movie.id,
                                                                   title: movie.title))
    }
}
