def add_bookmark
  visit('/')
  click_button('create bookmark')
  fill_in('url', with: 'http://www.tesco.com')
  fill_in('title', with: 'Tesco')
  click_button('create Bookmark')
  click_button('back')
end

def add_invalid_bookmark
  visit('/')
  click_button('create bookmark')
  fill_in('url', with: 'not a valid bookmark')
  fill_in('title', with: 'Error')
  click_button('create Bookmark')
end
