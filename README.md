# gh-user-storage

### Features
Query a github user, by username
- Uses github api to request the information
- Stores the user information into the db
    - Only if the user is not existing

The application checks every hour if the information of the users has changed
- This feature uses the gem 'whenever' 
    - See [Whenever Repo](https://github.com/javan/whenever)
- Will update a user record if his information has changed.

Record changes made to a user
- This feature uses the gem 'paper_trail'
    - See [Paper Trail Repo](https://github.com/paper-trail-gem/paper_trail)
    - Allows the developer to access and identify changes made to a record
