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

		# TODO: shitty??
		it "does not allow nil user" do
			vote = votes(:grace_givingtree)
			vote.user = nil
			vote.valid?.must_equal false
		end

		# TODO: shitty??
		it "does not allow nil work" do
			vote = votes(:grace_givingtree)
			vote.work = nil
			vote.valid?.must_equal false
		end

		it "only allow non-duplicate votes by a user" do
			user = users(:grace)
			Vote.create(work: works(:novotesbook), user: user)
			dup_vote = Vote.create(work: works(:novotesbook), user: user)
			dup_vote.valid?.must_equal false

			non_dup_vote = Vote.create(work: works(:novotesbooktwo), user: user)
			non_dup_vote.valid?.must_equal true
		end

	end

	# describe "relationship" do
	# 	it "it deletes itself if work has been deleted" do
	# 		work = Work.create(title: "foo", category: "book")
	# 		vote = Vote.create(work: work, user: users(:ada))
	#
	# 		work.delete
	# 		vote.must_be_nil
	# 	end
	#
	# end
end
