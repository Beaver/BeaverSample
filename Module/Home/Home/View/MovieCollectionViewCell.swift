import UIKit
import Core
import Alamofire
import AlamofireImage

final class MovieCollectionViewCell: UICollectionViewCell {
    
    private var needsSetup = true
    private let titleLabel: UILabel = UILabel()
    private let releaseDateLabel: UILabel = UILabel()
    private let imageView: UIImageView = UIImageView()
    private let averageNoteLabel: UILabel = UILabel()
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.white
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.casGray()
        imageView.contentMode = .scaleAspectFill
        
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.textColor = UIColor.gray
        releaseDateLabel.font = UIFont(name: "HelveticaNeue", size: 12)
        
        averageNoteLabel.translatesAutoresizingMaskIntoConstraints = false
        averageNoteLabel.textColor = UIColor.purple
        averageNoteLabel.font = UIFont(name: "HelveticaNeue-Light", size: 22)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(averageNoteLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        // will never be called
        fatalError("init(coder:) has not been implemented")
    }
    
    private func resetImage() {
        imageView.af_cancelImageRequest()
        imageView.image = nil
    }
    
    func initializeWith(movieState: MovieState) {
        resetImage()
        titleLabel.text = movieState.title
        if let url = URL(string: movieState.imageURL) {
            imageView.af_setImage(withURL: url, imageTransition: .crossDissolve(0.5))
        }
        releaseDateLabel.text = movieState.releaseDate
        averageNoteLabel.text = movieState.voteAverage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.masksToBounds = true
        layer.cornerRadius = 3
    }
    
    override func updateConstraints() {
        
        if needsSetup {
            self.setUpContraints()
            needsSetup = false
        }
        
        super.updateConstraints()
    }
    
    private func setUpContraints() {
        let views = [
            "titleLabel": titleLabel,
            "imageView": imageView,
            "releaseDateLabel": releaseDateLabel,
            "averageNoteLabel": averageNoteLabel
        ]
        
        var allConstraints = [NSLayoutConstraint]()
        
        let titleVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-15-[titleLabel]-5-[releaseDateLabel]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += titleVerticalConstraints
        
        let imageVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[imageView]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += imageVerticalConstraints
        
        let titleHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[imageView]-10-[titleLabel]-(>=3)-[averageNoteLabel]-15-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += titleHorizontalConstraints
        
        let imageViewWidthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 0.75, constant: 0)
        allConstraints += [imageViewWidthConstraint]
        
        let releaseDateLeadingConstraint = NSLayoutConstraint(item: releaseDateLabel, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1, constant: 0)
        allConstraints += [releaseDateLeadingConstraint]
        
        let averageNoteLabelVerticalConstraint = NSLayoutConstraint(item: averageNoteLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
        allConstraints += [averageNoteLabelVerticalConstraint]
        
        titleLabel.setContentCompressionResistancePriority(750, for: .horizontal)
        averageNoteLabel.setContentCompressionResistancePriority(1000, for: .horizontal)
        
        
        NSLayoutConstraint.activate(allConstraints)
    }
}
