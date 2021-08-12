//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation
import FeedFeature

final class FeedViewModel {
	typealias Observer<T> = (T) -> Void

	private let feedLoader: FeedLoader

	init(feedLoader: FeedLoader) {
		self.feedLoader = feedLoader
	}

	var title: String {
		Localized.Feed.title
	}

	var onLoadingStateChange: Observer<Bool>?
	var onFeedLoad: Observer<[FeedImage]>?
	var onLoadingErrorStateChanged: Observer<String?>?

	func loadFeed() {
		onLoadingStateChange?(true)
		onLoadingErrorStateChanged?(nil)
		feedLoader.load { [weak self] result in
			if let feed = try? result.get() {
				self?.onFeedLoad?(feed)
			} else {
				self?.onLoadingErrorStateChanged?(Localized.Feed.loadError)
			}
			self?.onLoadingStateChange?(false)
		}
	}
}
