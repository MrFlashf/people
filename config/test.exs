import Config

config :names_db, :names_db_api, NamesDBMock
config :people, :names_db_api, NamesDBMock
config :database, :repo, DatabaseMock
