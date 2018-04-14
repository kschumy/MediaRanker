require "test_helper"

describe User do
  describe "valid" do

    it "must be valid" do
      users(:lovelace).must_be :valid?
    end

    it "must have a name of at least one char" do
      new_user = User.create(name: "")
      new_user.valid?.must_equal false
      new_user.errors.must_include :name

      new_user = User.create(name: "         ")
      new_user.valid?.must_equal false

      new_user = User.create(name: "a")
      new_user.valid?.must_equal true
    end

    it "must have a unique name in same category" do
      new_user = User.create(name: users(:lovelace).name)
      new_user.valid?.must_equal false
      new_user.errors.must_include :name
      new_user.errors.messages[:name].must_equal ["has already been taken"]
    end

    it "removes strips white space from name" do
      valid_new_user = User.create(name: "Foo Bar")
      valid_new_user.valid?.must_equal true
      valid_new_user.name.must_equal "Foo Bar"

      invalid_new_user_one = User.create(name: "Foo       Bar")
      invalid_new_user_one.valid?.must_equal false
      invalid_new_user_one.errors.must_include :name

      invalid_new_user_two = User.create(name: "     Foo Bar")
      invalid_new_user_two.valid?.must_equal false
      invalid_new_user_one.errors.must_include :name
    end
  end

  it "must have a unique, case-insensitive name" do
    new_user_name = users(:lovelace).name
    new_user_name[0] = new_user_name.chr.swapcase
    new_user = User.create(name: new_user_name)

    new_user.valid?.must_equal false
    new_user.errors.must_include :name
  end

end
