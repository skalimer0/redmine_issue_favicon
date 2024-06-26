# frozen_string_literal: true

require 'redmine'

require File.expand_path('lib/issue_favicon_application_hooks', __dir__)
require File.expand_path('lib/issue_favicon_my_account_hooks', __dir__)
require File.expand_path('lib/issue_favicon_my_controller_patch', __dir__)

Redmine::Plugin.register :redmine_issue_favicon do
  name 'Redmine Issue Favicon plugin'
  author 'Akiko Takano'
  description 'Plugin to show the number of assigned issues on favicon with badge, using favico.js.'
  version '0.1.0'
  url 'https://github.com/akiko-pusu/redmine_issue_favicon'
  author_url 'http://twitter.com/akiko_pusu'
  requires_redmine version_or_higher: '5.0.0'

  settings partial: 'settings/redmine_issue_favicon',
           default: {
             'enable' => 'false'
           }

  Rails.configuration.to_prepare do
    require_dependency 'my_controller'
    MyController.prepend IssueFaviconMyControllerPatch unless MyController.included_modules.include?(IssueFaviconMyControllerPatch)
  end
end
