require "test_helper"

describe Vote do
	describe "valid" do
		it "must be valid" do
		  votes(:grace_givingtree).must_be :valid?
		end

		it "must be have a user" do
		  votes(:grace_givingtree).user.must_equal users(:grace)
		end

		it "must be have a work" do
		  votes(:grace_givingtree).work.must_equal works(:givingtree)
		end

		it "must have a valid user" do
			vote = votes(:grace_givingtree)
			proc { vote.user = "foo" }.must_raise ActiveRecord::AssociationTypeMismatch
		end

		it "must have a valid work" do
			vote = votes(:grace_givingtree)
			proc { vote.work = "foo" }.must_raise ActiveRecord::AssociationTypeMismatch
		end

		# TODO: bad??
		it "does not allow nil user" do
			vote = votes(:grace_givingtree)
			vote.user = nil
			vote.valid?.must_equal false
		end

		# TODO: bad??
		it "does not allow nil work" do
			vote = votes(:grace_givingtree)
			vote.work = nil
			vote.valid?.must_equal false
		end

	end
end
