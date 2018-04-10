require "test_helper"

describe Work do
  describe 'relations' do

   # it "has a votes" do
   #   work = works(:hpbook)
   #   work.votes.must_respond_to :last
   # end

   it 'updates with votes' do
     work = works(:hpbook)
     test_vote = Vote.create work: works(:hpbook), user: users(:ada)
     work.votes.last.must_equal test_vote
   end
  end

  describe "validate" do

  end

end
