# encoding: utf-8

Dado %r/^que eu esteja logado como administrador$/ do
  @user = FactoryGirl.create('admin/user')
  visit '/'
  fill_in 'Email', :with => @user.email
  fill_in 'Password', :with => @user.password
  click_button 'Sign in'
end
 
Então %r/^eu devo ver "([^"]*)" no título$/ do |text|
  page.find('h1.title').should have_content text
end

Então %r/^eu (não )?devo ver o menu "([^"]*)"$/ do |negation, menu|
  within '.navbar' do
    if negation
      page.find('ul.nav').should_not have_content menu
    else
      page.find('ul.nav').should have_content menu
    end
  end
end