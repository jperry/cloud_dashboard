include Warden::Test::Helpers
Warden.test_mode!

# Feature: Instance index page
#   As a user
#   I want to see a list of instances
#   So I can see what is being used
feature 'Instance index page', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: See all instances
  #   Given I am signed in
  #   When I visit the instance index page
  #   Then I see 5 rows of instance details
  scenario 'user sees list of instances', :js => true do
    VCR.use_cassette('all_instances') do
      user = FactoryGirl.create(:user, :admin)
      login_as(user, scope: :user)
      visit instances_path
      expect(page).to have_css("tbody tr", :count => 5)
      expect(page).to have_content('Showing 1 to 5 of 5 entries')
    end
  end

  # Scenario:
  #   Given the index page
  #   When the list is filtered via search
  #   Then I see only the matching instances
  scenario 'user sees list of instances', :js => true do
    VCR.use_cassette('all_instances', :allow_playback_repeats => true) do
      user = FactoryGirl.create(:user, :admin)
      login_as(user, scope: :user)
      visit instances_path
      fill_in 'Search:', :with => 'stopped'
      expect(page).to have_css("tbody tr", :count => 1)
      expect(page).to have_content('Showing 1 to 1 of 1 entries (filtered from 5 total entries)')
    end
  end

  # Scenario: Pagination buttons
  #   Given the index page
  #   When visiting the instances index page
  #   Then I see a Previous, Next and Current Page
  scenario 'user sees paginated buttons', :js => true do
    VCR.use_cassette('all_instances', :allow_playback_repeats => true) do
      user = FactoryGirl.create(:user, :admin)
      login_as(user, scope: :user)
      visit instances_path
      expect(page).to have_link('Previous')
      expect(page).to have_link('Next')
      expect(page).to have_link('1')
    end
  end

  # Scenario: Sorting Columns on index page
  #   Given the index page
  #   When clicking the header of a column
  #   Then I see the instances sorted by that column data
  scenario 'user can sort data by columns', :js => true do
    VCR.use_cassette('all_instances', :allow_playback_repeats => true) do
      user = FactoryGirl.create(:user, :admin)
      login_as(user, scope: :user)
      visit instances_path
      find('.sorting_asc', :text => 'Name').click
      find('.sorting', :text => 'Id').click
      find('.sorting', :text => 'Type').click
      find('.sorting', :text => 'State').click
      find('.sorting', :text => 'AZ').click
      find('.sorting', :text => 'Public IP').click
      find('.sorting', :text => 'Private IP').click
    end
  end

  # Scenario: See filtered instances
  #   Given the index page
  #   When the list is filtered via search
  #   Then I see only the matching instances
  scenario 'user can filter results', :js => true do
    VCR.use_cassette('all_instances', :allow_playback_repeats => true) do
      user = FactoryGirl.create(:user, :admin)
      login_as(user, scope: :user)
      visit instances_path
      fill_in 'Search:', :with => 'stopped'
      expect(page).to have_css("tbody tr", :count => 1)
      expect(page).to have_content('Showing 1 to 1 of 1 entries (filtered from 5 total entries)')
    end
  end
end
