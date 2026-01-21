require "application_system_test_case"

class EntryBrowsingTest < ApplicationSystemTestCase
  test "can view home page and navigate to entries" do
    visit root_url

    assert_selector "h1", text: "At Dawn, I Am"
    assert_selector "a", text: "view all entries"

    click_on "view all entries"

    assert_selector "h1", text: "All Entries"
    assert_selector "a", text: "read full entry"
  end

  test "can view individual entry" do
    entry = entries(:one)

    visit entry_url(entry)

    assert_selector "h1", text: /Entry from/
    assert_selector "div.prose", text: /#{Regexp.escape(entry.body)}/i
    assert_selector "a", text: "← all entries"
    assert_selector "a", text: "home"
  end

  test "cannot access admin without authentication" do
    visit admin_root_url

    assert_current_path admin_login_path
    assert_selector "h2", text: /Admin Login/i
  end

  test "can use admin login flow" do
    visit admin_login_path

    fill_in "Email address", with: "naijeria@gmail.com"
    click_on "Send Magic Link"

    assert_text "Magic link sent to your email"
  end
end
