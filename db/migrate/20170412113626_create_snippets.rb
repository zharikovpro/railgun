class CreateSnippets < ActiveRecord::Migration[5.0]
  def up
    execute 'CREATE EXTENSION citext;'

    execute 'CREATE TABLE snippets (
      id serial NOT NULL,
      slug citext NOT NULL,
      text text NOT NULL,
      CONSTRAINT pk_snippets PRIMARY KEY (id),
      CONSTRAINT unique_index_snippets_on_slug UNIQUE (slug)
    );'
  end

  def down
    drop_table :snippets
  end
end
