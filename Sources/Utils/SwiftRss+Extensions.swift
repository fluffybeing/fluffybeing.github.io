import SwiftRss

open class AtomLink: Tag {
	open override class func createNode() -> Node {
		Node(type: .standard, name: "atom:link")
	}
}
