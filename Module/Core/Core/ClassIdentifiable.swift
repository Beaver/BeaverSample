public protocol ClassIdentifiable {
    static func identifier() -> String
}

extension ClassIdentifiable {
    public static func identifier() -> String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ClassIdentifiable {
   
}
