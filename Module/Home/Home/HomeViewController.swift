import Beaver
import Core

final class HomeViewController: Beaver.ViewController<HomeState, AppState, HomeUIAction>, UITableViewDataSource, UITableViewDelegate {
    lazy private var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dispatch(action: .didViewAppear)
    }
        
    override func stateDidUpdate(oldState: HomeState?,
                                 newState: HomeState,
                                 completion: @escaping () -> ()) {
        if oldState != newState {
            tableView.reloadData()
        }
        completion()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state.movies?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = state.movies?[indexPath.row].title
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movies = state.movies else {
            fatalError("Can't select a movie if state doens't have any movie")
        }
        
        let movie = movies[indexPath.row]
        
        dispatch(action: HomeUIAction.didTapOnMovieCell(id: movie.id,
                                                        title: movie.title))
    }
}
