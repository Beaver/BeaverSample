import Beaver
import Core

enum HomeUIAction: HomeAction {
    case finish
    case didLoadView
    case didPullToRefresh
    case didScrollToBottom
    case didViewAppear
    case didTapOnMovieCell(id: Int, title: String)
}
