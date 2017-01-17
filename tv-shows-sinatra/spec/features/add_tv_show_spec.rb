require "spec_helper"

feature "user adds a new TV show" do
  # As a TV fanatic
  # I want to add one of my favorite shows
  # So that I can encourage others to binge watch it
  #
  # Acceptance Criteria:
  # * I must provide the title, network, and starting year.
  scenario 'user supplies title, network and starting year' do
    visit '/'
    click_link 'Add New Show'
    fill_in 'Title', with: 'NCIS'
    fill_in 'Network', with: 'NBC'
    fill_in 'Starting Year', with: '2001'
    click_button 'Add TV Show'
    expect(page).to have_content("NCIS")

  end
  # * I can optionally provide the final year, genre, and synopsis.
  scenario 'if user supplies final year, genre or synopsis' do
    visit '/'
    click_link 'Add New Show'
    fill_in 'Title', with: 'NCIS'
    fill_in 'Network', with: 'NBC'
    fill_in 'Starting Year', with: '2001'
    fill_in 'Ending Year', with: '2015'
    select('Action', :from =>'Genre')
    fill_in 'Synopsis', with: 'special agents solve crimes'

    expect(page).to have_css("a[href='/television_shows']")

  end
  # * The synopsis can be no longer than 5000 characters.
  scenario 'synopsis has a limit of 5000 characters' do
    visit '/'
    click_link 'Add New Show'
    fill_in 'Title', with: 'NCIS'
    fill_in 'Network', with: 'NBC'
    fill_in 'Starting Year', with: '2001'
    fill_in 'Synopsis', with: 'special agents solve crimes'
    click_button 'Add TV Show'

    expect(page).to have_current_path("/television_shows")
  end
  # * The starting year and ending year (if provided) must be
  #   greater than 1900.
  scenario 'starting year is greater than 1900' do
    visit '/'
    click_link 'Add New Show'
    fill_in 'Title', with: 'NCIS'
    fill_in 'Network', with: 'NBC'
    fill_in 'Starting Year', with: '2001'
    fill_in 'Synopsis', with: 'special agents solve crimes'
    click_button 'Add TV Show'
    click_link 'NCIS'

    find_link('Back to all shows', :visible => :all).visible?
  end

  # * The genre must be one of the following: Action, Mystery,
  #   Drama, Comedy, Fantasy
  scenario 'if genre is supplied, it must be Action, Mystery, Drama, Comedy or Fantasy' do
    visit '/'
    click_link 'Add New Show'
    fill_in 'Title', with: 'NCIS'
    fill_in 'Network', with: 'NBC'
    fill_in 'Starting Year', with: '2001'
    fill_in 'Ending Year', with: '2015'
    select('Action', :from =>'Genre')
    fill_in 'Synopsis', with: 'special agents solve crimes'


    find_button('Add TV Show').click
  end

  # * If any of the above validations fail, the form should be
  #   re-displayed with the failing validation message.
  scenario 'if the title validation fails, failing validation message appears' do
    visit '/'
    click_link 'Add New Show'
    fill_in 'Title', with: 'NCIS'
    fill_in 'Network', with: 'NBC'
    fill_in 'Starting Year', with: '1801'
    fill_in 'Ending Year', with: '2015'
    select('Action', :from =>'Genre')
    fill_in 'Synopsis', with: 'special agents solve crimes'
    click_button 'Add TV Show'

    expect(page).to have_content("Errors!")
  end

end
