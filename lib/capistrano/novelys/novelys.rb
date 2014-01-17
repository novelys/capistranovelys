## Default Novelys app configuration

set(:user)             { application }
set(:deploy_to)        { "/home/#{user}/www/" }
set(:github_account)   { 'novelys' }
set(:repository)       { "git@github.com:#{github_account}/#{application}" }
