public func ===<T: Sequence>(lseq: T?, rseq: T?) -> Bool where T.Iterator.Element: Equatable {
    if lseq == nil && rseq == nil {
        return true
    }
    
    if let lseq = lseq {
        if let rseq = rseq {
            return lseq.elementsEqual(rseq, by: { (lelement, relement) -> Bool in
                return lelement == relement
            })
        }
    }
    return false
}
