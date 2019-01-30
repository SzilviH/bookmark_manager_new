require 'pg'

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
    fill_in('url', with: 'www.tesco.com')
    fill_in('title', with: 'Tesco')
    click_button('create Bookmark')
    expect(page).to have_link("Tesco", href: "www.tesco.com")
  end
end

feature 'Viewing bookmarks' do
  scenario "Displays all bookmarks" do
    Bookmark.create(url: "www.google.com", title: "Google")
    Bookmark.create(url: "www.yahoo.com", title: "Yahoo")
    visit('/bookmarks')
    expect(page).to have_link("Google", href: "www.google.com")
    expect(page).to have_link("Yahoo", href: "www.yahoo.com")
  end
end

feature 'Deleting bookmarks' do
  scenario "Deletes a bookmark" do
    visit('/')
    click_button('create bookmark')
    fill_in('url', with: 'www.tesco.com')
    fill_in('title', with: 'Tesco')
    click_button('create Bookmark')
    click_button('back')
    fill_in('delete_title', with: 'Tesco')
    click_button('delete bookmark')
    click_button('view bookmarks')
    expect(page).not_to have_link("Tesco", href: "www.tesco.com")
  end
end
