require "test_helper"

describe ShiftJobsController do
  it "should get new" do
    get shift_jobs_new_url
    value(response).must_be :success?
  end

end
