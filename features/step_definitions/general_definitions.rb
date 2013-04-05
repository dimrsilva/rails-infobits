# encoding: utf-8

Dado %r/^que eu esteja logado como administrador$/ do
  @user = FactoryGirl.create('admin/user')
  visit '/'
  fill_in 'Email', :with => @user.email
  fill_in 'Password', :with => @user.password
  click_button 'Sign in'
end

Dado %r/^que eu visite a url "([^"]*)"$/ do |page|
  visit page
end
 
Então %r/^eu devo ver "([^"]*)" no título$/ do |text|
  page.find('h1.title').should have_content text
end