require "test_helper"

describe WorksController do
	it "should get index" do
    get works_path
    must_respond_with :success
  end

  it "should get show" do
    get works_path(works(:hpbook).id)
    must_respond_with :success
  end

	it "should get create" do
		get works_path
		must_respond_with :success
	end

  it "should get update" do
    # get authors_update_url
    # value(response).must_be :success?
  end

  it "should get new" do
		get new_work_path
		must_respond_with :success
  end

  it "should get create" do
    # get authors_create_url
    # value(response).must_be :success?
  end

  it "should get destroy" do
		get works_path(works(:hpbook).id)
		must_respond_with :success
  end

end
