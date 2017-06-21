import Core

final class HomeViewController: Stage<HomeAction>,
                                UICollectionViewDataSource,
                                UICollectionViewDelegate,
                                UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    private enum Constant {
        static let margin: CGFloat = 15
        static let cellHeight: CGFloat = 100
        static let fetchThreshold = 10
    }
    
    var collectionView: UICollectionView?
    var refresher:UIRefreshControl?
    var activityIndicatorView: UIActivityIndicatorView?
    
    // MARK: - Inits
    
    override init(script: Script<HomeAction>) {
        super.init(script: script)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupCollectionView()
        setupActivityIndicator()
        showIndicator()
        
        dispatch(action: HomeAction.main(.didLoadView))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        dispatch(action: HomeAction.main(.didViewAppear))
    }
    
    // MARK: - Setup
    
    private func setupNavigationBar() {
        title = "Beaver"
        navigationController?.navigationBar.barTintColor = UIColor.black.withAlphaComponent(0.6)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    private func setupActivityIndicator() {
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        guard let activityIndicatorView = activityIndicatorView else {
            return
        }
        
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicatorView)
        
        let centerXConstraint = NSLayoutConstraint(item: activityIndicatorView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: activityIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        view.addConstraints([centerXConstraint, centerYConstraint])
    }
    
    private func setupCollectionView() {
        // layout
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.backgroundColor = UIColor.black
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let refresher = UIRefreshControl()
        collectionView.alwaysBounceVertical = true
        refresher.tintColor = UIColor.white
        refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        collectionView.addSubview(refresher)
        
        self.refresher = refresher
        
        view.addSubview(collectionView)
        setupCollectionViewConstraints()
    }
    
    private func setupCollectionViewConstraints() {
        if let collectionView = collectionView {
            
            let views = [
                "collectionView":collectionView
            ]
        
            var constraints =  NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions.alignAllTop, metrics: nil, views: views)
            view.addConstraints(constraints)
            
            constraints =  NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-|", options: [], metrics: nil, views: views)
            view.addConstraints(constraints)
        }
    }
    
    // MARK: - UI Updates
    
    func loadData()
    {
        dispatch(action: HomeAction.main(.didPullToRefresh))
    }
    
    private func showIndicator() {
        collectionView?.isHidden = true
        activityIndicatorView?.startAnimating()
    }
    
    private func hideIndicator() {
        collectionView?.isHidden = false
        activityIndicatorView?.stopAnimating()
    }
    
    override func stateDidUpdate(oldState: HomeState?,
                                 newState: HomeState) -> SafePromise<()> {
        if newState.error != nil {
            return SafePromise(value: ())
        }
        
        updateMovies(oldState: oldState, newState: newState)
        
        return SafePromise(value: ())
    }
    
    private func updateMovies(oldState: HomeState?, newState: HomeState) {
        
        guard !(oldState?.movies === newState.movies) else {
            refresher?.endRefreshing()
            return
        }
        
        hideIndicator()
        
        if let movies = newState.movies {
            // data
            if movies.isEmpty {
                collectionView?.reloadData()
            } else {
                if let oldMovies = oldState?.movies, !oldMovies.isEmpty, oldMovies.count < movies.count {
                    var indexPaths: [IndexPath] = []
                    for i in oldMovies.count...(movies.count-1) {
                        indexPaths.append(IndexPath(row: i, section: 0))
                    }
                    self.collectionView?.insertItems(at: indexPaths)
                } else {
                    collectionView?.reloadData()
                }
            }
        } else {
            // placeholder
            collectionView?.reloadData()
        }
        refresher?.endRefreshing()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return state.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier(), for: indexPath) as? MovieCollectionViewCell {
            if let movieState = state.movies?[indexPath.row] {
                cell.initializeWith(movieState: movieState)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let count = state.movies?.count, (count - indexPath.row) == Constant.fetchThreshold && state.hasNextMovies {
            dispatch(action: HomeAction.main(.didScrollToBottom))
        }
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = state.movies?[indexPath.row] else {
            return
        }
        dispatch(action: HomeAction.main(.didTapOnMovieCell(id: movie.id, title: movie.title, imageURL: movie.backdropPath, overview: movie.overview)))
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.regular {
            return CGSize(width: view.frame.width * 0.7, height: Constant.cellHeight)
        }
        return CGSize(width: view.frame.width - 2 * Constant.margin, height: Constant.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(15, Constant.margin, 15, Constant.margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
}

/* ISSUE: https://bugs.swift.org/browse/SR-857 */
//extension HomeStage: UICollectionViewDataSource {
//    
//    
//}
