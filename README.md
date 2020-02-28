# stoverflow
A simple app to show the top 20 users from Stack Overflow and display them in a table, allowing mock following and blocking of each user.

# Running
To build the project, you will need Xcode 11.3 or higher as the app is targeting iOS 13.2.

There are two launch arguments - usingMockData and resetDatabase. usingMockData will use a set of mock local users instead of retrieving any from the API and use a separate persistent container than the regular environment, and resetDatabase will clear any persistent data the app has created up to this point - for the container the app is using for the launch, so this will clear the mock database if used with usingMockData or the real one if not.

# Design decisions
## API Client
The idea behind the API client is to allow for new requests and entity types to be added without having to change the logic for the client. The client type is only associated with the protocols for API Request, so all kinds of subclasses can be added with different kinds of associated entities and the client will be able to cope with all of them, so long as they fit the protocol.

## Testing
The approach for testing was to allow mocking both at an individiaul class level for unit testing but also at an app level for UI testing. The MockStackOverflowClient was created for this purpose - it can replace the singleton for UI tests but can also be configured for testing the specific business logic which uses it.

## Structure
The decision to use coordinators was made with extenability in mind, providing the structure to include more pages and complex flow if required. 
