# haint-tymex-test
# Github Users Browser

An iOS application built with Swift and Combine that displays a list of GitHub users and allows you to view user details, including follower statistics and blog information.

## 📱 Features

- Fetches a paginated list of GitHub users from the [GitHub API](https://docs.github.com/en/rest).
- Caches user list data locally using `UserDefaults` to improve launch performance.
- Displays detailed information for each user including:
  - Avatar
  - Name, Username
  - Follower/Following count
  - Blog URL (if available)
- Lazy loading: loads more users as the user scrolls.
- Fully MVVM structured with Combine and async/await.
- Handles loading and error states.

## 🛠 Technology Stack

- Swift 5.9+
- Combine
- Swift Concurrency (`async/await`)
- MVVM Architecture
- Kingfisher (image loading & caching)
- Swift Package Manager (for dependency management)

## 📦 Dependencies

- [Kingfisher](https://github.com/onevcat/Kingfisher) (via Swift Package Manager)

## 🚀 Installation

Clone this repository:
   ```bash
   git clone https://github.com/yourusername/github-users-browser.git
