# Overload buffer pointer's `MutableCollection` methods nonmutating.

Currently this code is not compilable.

```swift
func median<T: Comparable>(bp: UnsafeMutableBufferPointer<T>) {
    bp.sort() // error: cannot use mutating member on immutable value: 'bp' is a 'let' constant
    return bp[bp.count/2]
}
```

It is because `sort`, defined in [`MutableColelction`](https://developer.apple.com/documentation/swift/mutablecollection), is  `mutating`.

By the way `subscript` and `swapAt`, also defined as `mutating` in `MutableCollection`, are overloaded as nonmutating in `UnsafeMutableBufferPointer`.
I think it's natural to overload other methods, `partition`, `reverse`, `shuffle`, and `sort` likewise.

What do you think?

Other types:
- `UnsafeMutableRawBufferPointer` also has this problem.
- `UnsafeMutableAudioBufferListPointer` also has this problem(But it's in CoreAudio).
- `EmptyCollection`'s methods can be nonmutating since these does nothing.