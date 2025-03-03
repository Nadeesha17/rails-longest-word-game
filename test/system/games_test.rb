require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_path
    assert_selector "h1", text: "Longest Word Game"
    assert_selector "h2.text-primary", count: 1
  end

  test "Submitting a word not in the grid" do
    visit new_path
    fill_in "word", with: "HELLO"
    click_on "Submit"
    assert_text "The word can't be built from the given letters."
  end

  test "Submitting a word that is not an English word" do
    visit new_path
    fill_in "word", with: "ZXQJ"
    click_on "Submit"
    assert_text "This is not a valid English word."
  end

  test "Submitting a valid English word" do
    visit new_path
    fill_in "word", with: "CAT"
    click_on "Submit"
    assert_text "Congratulations!"
  end
end
