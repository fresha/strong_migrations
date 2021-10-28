import Config

config :strong_migrations,
  migration_paths: [
    "priv/repo/migrations"
  ],
  classifiers: [
    StrongMigrations.Classifiers.AddIndexConcurrentlyInTransaction
  ]
