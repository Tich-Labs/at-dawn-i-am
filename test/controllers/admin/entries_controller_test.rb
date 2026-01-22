require "test_helper"

class Admin::EntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_entry_url
    assert_response :success
  end

  test "should get edit" do
    entry = Entry.create!(date: Date.today, body: "Test entry", status: "published", image: nil)
    get edit_admin_entry_url(entry)
    assert_response :success
  end

  test "should update entry" do
    entry = Entry.create!(date: Date.today, body: "Original entry", status: "draft", image: nil)
    patch admin_entry_url(entry), params: { entry: { body: "Updated entry" } }
    assert_redirected_to admin_entry_path(entry)
    follow_redirect!
    assert_select "h1", text: /Edit Journal Entry/
  end

  test "should create entry" do
    entry_params = {
      date: Date.today,
      body: "New test entry",
      status: "published",
      image: nil
    }
    post admin_entries_url, params: { entry: entry_params }
    assert_redirected_to admin_entry_path(assigns(:entry))
    follow_redirect!
    assert_select "h1", text: /Edit Journal Entry/
  end

  test "should destroy entry" do
    entry = Entry.create!(date: Date.today, body: "Test entry", status: "published", image: nil)
    delete admin_entry_url(entry)
    assert_redirected_to admin_entries_path
    assert_not Entry.exists?(entry.id)
  end

  test "should show entry" do
    entry = Entry.create!(date: Date.today, body: "Test entry", status: "published", image: nil)
    get admin_entry_url(entry)
    assert_response :success
    assert_select "h1", text: /Edit Journal Entry/
  end

  test "should update entry status" do
    entry = Entry.create!(date: Date.today, body: "Test entry", status: "published")
    patch update_status_admin_entry_path(entry), params: { status: "hidden" }
    assert_redirected_to admin_entries_path(highlighted_entry: entry.id)
    entry.reload
    assert_equal "hidden", entry.status
  end
end
