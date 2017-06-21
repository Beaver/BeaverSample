import Core
import PromiseKit
import API

extension HomeScene: Directing {
    typealias ActionType = HomeAction

    func handle(action envelop: ActionEnvelop<HomeAction>, state: HomeState) -> Promise<HomeState> {
        switch envelop.action {
        case .main(.didLoadView),
             .main(.didPullToRefresh):
            var newState = state
            newState.currentStage = .main
            return reset(state: newState)
        case .main(.didViewAppear):
            var newState = state
            newState.currentStage = .main
            return Promise(value: newState)
        case .main(.didScrollToBottom):
            return loadNext(state: state)
        case .main(.didTapOnMovieCell(id: let id, title: let title, imageURL: let imageURL, overview: let overview)):
            var newState = state
            newState.currentStage = .movieCard(id: id, title: title, imageURL: imageURL, overview: overview)
            return Promise(value: newState)
        }
    }
}

private extension HomeScene {
    
    func reset(state: HomeState) -> Promise<HomeState> {
        var newState = state
        
        return firstly { _ -> Promise<Page<Movie>> in
            let request = Movie.topRated()
            return request.toPromise(using: self.api)
        }.then { page in
            newState.movies = page.resources.map { movie in
                return MovieState(movie: movie)
            }
            newState.page = page.id
            newState.hasNextMovies = (page.id < page.pageCount)
            return Promise(value: newState)
        }
    }
    
    func loadNext(state: HomeState) -> Promise<HomeState> {
        var newState = state
        
        return firstly { _ -> Promise<Page<Movie>> in
            let topRatedRequest = Movie.topRated()
            let request = Page<Movie>.get(at: state.page + 1, from: topRatedRequest)
            return request.toPromise(using: self.api)
            }.then { page in
                newState.movies? += page.resources.map { movie in
                    return MovieState(movie: movie)
                }
                newState.page = page.id
                newState.hasNextMovies = (page.id < page.pageCount)
                return Promise(value: newState)
        }
    }
}
