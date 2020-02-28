# stoverflow
A simple app to show the top 20 users from Stack Overflow and display them in a table, allowing mock following and blocking of each user.

# Running
To build the project, you will need Xcode 11.3 or higher as the app is targeting iOS 13.2.

There are two launch arguments - usingMockData and resetDatabase. usingMockData will use a set of mock local users instead of retrieving any from the API and use a separate persistent container than the regular environment, and resetDatabase will clear any persistent data the app has created up to this point - for the container the app is using for the launch, so this will clear the mock database if used with usingMockData or the real one if not.
