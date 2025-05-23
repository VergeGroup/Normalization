# ``Normalization``

## Overview

State management plays a crucial role in building efficient and maintainable applications. One of the essential aspects of state management is organizing the data in a way that simplifies its manipulation and usage. This is where normalization becomes vital.

Normalization is the process of structuring data in a way that eliminates redundancy and ensures data consistency. It is essential in state-management libraries because it significantly reduces the computational complexity of operations and makes it easier to manage the state.

Let's take a look at an example to illustrate the difference between normalized and denormalized data structures.
 
[Redux's normalization explanations](https://redux.js.org/usage/structuring-reducers/normalizing-state-shape) are also useful to understatnd the concept of normalization.

**Denormalized data structure:**


```yaml
posts:
  - id: 1
    title: "Post 1"
    author:
      id: 1
      name: "Alice"
  - id: 2
    title: "Post 2"
    author:
      id: 1
      name: "Alice"
  - id: 3
    title: "Post 3"
    author:
      id: 2
      name: "Bob"
```

In the denormalized structure, author data is duplicated in each post, which can lead to inconsistencies and make it harder to manage the state.

**Normalized data structure:**


```yaml
entities:
  authors:
    1:
      id: 1
      name: "Alice"
    2:
      id: 2
      name: "Bob"
  posts:
    1:
      id: 1
      title: "Post 1"
      authorId: 1
    2:
      id: 2
      title: "Post 2"
      authorId: 1
    3:
      id: 3
      title: "Post 3"
      authorId: 2
```

In the normalized structure, author data is stored separately from posts, eliminating data redundancy and ensuring data consistency. The relationship between posts and authors is represented by the `authorId` field in the posts.

Normalization is designed to handle normalization in state-management libraries effectively. By leveraging Normalization, you can simplify your state management, reduce the computational complexity of operations, and improve the overall performance and maintainability of your application.

**Defining Entities**

Here's an example of how to define the `Book` and `Author` entities:

```swift
struct Book: EntityType {
  
  typealias TypedIdentifierRawValue = String
  
  var typedID: TypedID {
    .init(rawID)
  }
  
  let rawID: String
  var name: String = "initial"
  let authorID: Author.EntityID
}

struct Author: EntityType {
  
  typealias TypedIdentifierRawValue = String
  
  var typedID: TypedID {
    .init(rawID)
  }
    
  let rawID: String
  var name: String = ""
}
```

**Defining Database Schema**

To store the entities in the state, you need to define the database schema:

```swift
@NormalizedStorage
struct Database {

  @Table
  var books: Tables.Hash<Book> = .init()

  @Table
  var authors: Tables.Hash<Book> = .init()
}
```

**Embedding the Database in State**

Embed the `Database` in your application's state:

```swift
struct RootState {
  var database: Database = .init()
}
```

**Storing and Querying Entities**

Writing

```swift
var state: RootState

state.database.performBatchUpdates { context in
  let authors = (0..<10).map { i in
    Author(rawID: "\(i)")
  }
  let result = context.modifying.author.insert(authors)
}
```

Reading

```swift
let book = state.database.db.book.find(by: .init("1"))
let author = state.database.db.author.find(by: .init("1"))
```

By using VergeNormalization, you can efficiently manage your application state with a normalized data structure, which simplifies your state management, reduces the computational complexity of operations, and improves the overall performance and maintainability of your application.


