@usableFromInline
func run<R>(f: () throws -> R) rethrows -> R {
    return try f()
}
