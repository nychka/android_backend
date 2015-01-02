
class WelcomeController < ApplicationController
  def index
    changelog = File.open('CHANGELOG.md', 'r').read
    @content = markdown(changelog)
  end
end
