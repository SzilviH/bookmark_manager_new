require 'pg'
require_relative 'web_helpers'

feature 'Testing infrastructure' do
  scenario 'It should visit main page and display main text' do
    visit('/')
    expect(page).to have_content "Welcome to your bookmark manager"
    expect(page).to have_content "Please select from the below options"
  end
end

feature 'Adding bookmarks' do
  scenario 'I can add a bookmark to the Bookmark Manager' do
    visit('/')
    click_button('create bookmark')
    fill_in('url', with: 'http://www.tesco.com')
    fill_in('title', with: 'Tesco')
    click_button('create Bookmark')
    expect(page).to have_link("Tesco", href: "http://www.tesco.com")
  end
  scenario 'bookmark must have a valid URL' do
    add_invalid_bookmark
    expect(page).not_to have_content "not a valid bookmark"
  expect(page).to have_content "You must submit a valid URL."
  end
end

feature 'Viewing bookmarks' do
  scenario "Displays all bookmarks" do
    Bookmark.create(url: "http://www.google.com", title: "Google")
    Bookmark.create(url: "http://www.yahoo.com", title: "Yahoo")
    visit('/bookmarks')
    expect(page).to have_link("Google", href: "http://www.google.com")
    expect(page).to have_link("Yahoo", href: "http://www.yahoo.com")
  end
end

feature 'Deleting bookmarks' do
  scenario "Deletes a bookmark" do
    add_bookmark
    fill_in('delete_title', with: 'Tesco')
    click_button('delete bookmark')
    click_button('view bookmarks')
    expect(page).not_to have_link("Tesco", href: "http://www.tesco.com")
  end
end


feature 'Updating bookmarks' do
  scenario "Updates a bookmark" do
    add_bookmark
    fill_in('old_title', with: 'Tesco')
    fill_in('update_title', with: 'Tesco Updated')
    fill_in('update_url', with: 'http://www.tesco.com/updated')
    click_button('update bookmark')
    click_button('view bookmarks')
    expect(page).to have_link("Tesco Updated", href: "http://www.tesco.com/updated")
  end
end
