require "test_helper"

describe User do
  describe "valid" do

    it "must be valid" do
      users(:lovelace).must_be :valid?
    end

    # it "removes strips white space from name" do
    #   valid_new_work = Work.create(title: "foo bar         baz", category: "book")
    #   valid_new_work.valid?.must_equal true
    #   valid_new_work.title.must_equal "foo bar baz"
    #
    #   invalid_new_work_one = Work.create(title: "foo    bar   baz", category: "book")
    #   invalid_new_work_one.valid?.must_equal false
    #   invalid_new_work_one.errors.must_include :title
    #
    #   invalid_new_work_two = Work.create(title: "   foo bar baz", category: "book")
    #   invalid_new_work_two.valid?.must_equal false
    # end
  end
end
