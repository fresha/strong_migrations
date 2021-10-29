# StrongMigrations

[![Build Status](https://github.com/patrykwozinski/strong_migrations/workflows/CI/badge.svg)](https://github.com/patrykwozinski/strong_migrations/actions)
[![Module Version](https://img.shields.io/hexpm/v/strong_migrations.svg)](https://hex.pm/packages/strong_migrations)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/strong_migrations/)
[![Total Download](https://img.shields.io/hexpm/dt/strong_migrations.svg)](https://hex.pm/packages/strong_migrations)
[![License](https://img.shields.io/hexpm/l/strong_migrations.svg)](https://github.com/patrykwozinski/strong_migrations/blob/master/LICENSE.md)
[![Last Updated](https://img.shields.io/github/last-commit/patrykwozinski/strong_migrations.svg)](https://github.com/patrykwozinski/strong_migrations/commits/master)

**Catch unsafe migrations in your Elixir application**

## Table of Contents
* [What Is it?](#what-is-it)
* [How to Install?](#how-to-install)

## What is it
`strong_migrations` is a library that protects your application from invoking unsafe migrations, they needs to be marked as a safe.

#### Features
- checking if your migrations are adding an index concurrently in transaction
- checking if your migrations are removing an index concurrently in transaction
- checking if your migrations are renaming columns (it's always better to remove old and add new column)
- checking if your migrations are removing columns
- you can keep safety assured info when adding `@safety_assured [:drop_column, :drop_table, :rename_column]`, etc if something has safety assured
... tbd

## How to install
The package can be installed by adding `strong_migrations` to your list of dependencies in `mix.exs` as follows.

Update your `mix.exs`:
```elixir
def deps do
  [
    {:strong_migrations, "~> 0.1", only: :dev}
  ]
end
```
