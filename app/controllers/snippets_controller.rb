class SnippetsController < ApplicationController

  def index
    skip_policy_scope
    @snippets = Snippet.all.map(&:slug)
  end
end
