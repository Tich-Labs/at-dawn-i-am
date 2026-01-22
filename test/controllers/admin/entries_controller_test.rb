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
    entry = create_test_entry
    get edit_admin_entry_url(entry)
    assert_response :success
  end

  test "should update entry" do
    entry = create_test_entry
    patch admin_entry_url(entry), params: { entry: { body: "Updated entry" } }
    assert_redirected_to admin_entries_path(highlighted_entry: entry.id)
  end

  test "should create entry" do
    image_file = fixture_file_upload("test/fixtures/files/test_image.jpg", "image/jpeg")
    entry_params = {
      date: Date.today,
      body: "New test entry",
      status: "published",
      image: image_file
    }
    post admin_entries_url, params: { entry: entry_params }
    assert_redirected_to admin_entries_path(highlighted_entry: assigns(:entry).id)
  end

  test "should destroy entry" do
    entry = create_test_entry
    delete admin_entry_url(entry)
    assert_redirected_to admin_entries_path
    assert_not Entry.exists?(entry.id)
  end

  test "should show entry" do
    entry = create_test_entry
    get admin_entry_url(entry)
    assert_redirected_to edit_admin_entry_path(entry)
  end

  test "should update entry status" do
    entry = create_test_entry
    patch update_status_admin_entry_path(entry), params: { status: "hidden" }
    assert_redirected_to admin_entries_path(highlighted_entry: entry.id)
    entry.reload
    assert_equal "hidden", entry.status
  end

  private

  def create_test_entry
    # Create a temporary file for the image
    image_file = fixture_file_upload("test/fixtures/files/test_image.jpg", "image/jpeg")
    Entry.create!(
      date: Date.today,
      body: "Test entry",
      status: "published",
      image: image_file
    )
  end
end
