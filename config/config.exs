import Config

config :strong_migrations,
  migration_paths: [
    "priv/repo/migrations"
  ]

import_config "#{config_env()}.exs"
