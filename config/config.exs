import Config

config :strong_migrations,
  migration_paths: [
    "priv/repo/migrations"
  ],
  classifiers: [
    StrongMigrations.Classifiers.AddIndexConcurrentlyInTransaction,
    StrongMigrations.Classifiers.AddIndexNotConcurrently,
    StrongMigrations.Classifiers.DropIndexConcurrentlyInTransaction,
    StrongMigrations.Classifiers.DropTable,
    StrongMigrations.Classifiers.RemoveColumn,
    StrongMigrations.Classifiers.RenameColumn
  ]
