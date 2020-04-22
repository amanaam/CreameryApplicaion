require "test_helper"

describe JobsController do
  it "should get new" do
    get jobs_new_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get jobs_edit_url
    value(response).must_be :success?
  end

  it "should get show" do
    get jobs_show_url
    value(response).must_be :success?
  end

  it "should get index" do
    get jobs_index_url
    value(response).must_be :success?
  end

end
