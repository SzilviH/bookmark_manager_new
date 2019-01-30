def add_bookmark
  visit('/')
  click_button('create bookmark')
  fill_in('url', with: 'www.tesco.com')
  fill_in('title', with: 'Tesco')
  click_button('create Bookmark')
  click_button('back')
end
