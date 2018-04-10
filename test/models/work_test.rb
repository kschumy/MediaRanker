require "test_helper"

describe Work do
  describe 'relations' do

   it "has a votes" do
     work = works(:hpbook)
     work.votes.must_equal []
   end

   it 'updates with votes' do
     work = works(:hpbook)
     test_vote = Vote.create(work: works(:hpbook), user: users(:ada))
     work.votes.must_equal [test_vote]
   end
  end

end


#
# describe "first published" do
#  it "should return the earliest published work for the author with multiple works" do
#    work.author = Author.create name: "Kari B"
#    value(work).must_be :valid?
#  end
#
#  it "must have as title" do
#    work.author = Author.create name: "Kari B"
#    work.title = nil
#    work.valid?.must_equal false # must have a title
#    work.errors.must_include :title
#  end
#
#  it "must have title between 1 and 25 characters" do
#    work.author = Author.create name: "Kari B"
#    work.title = ""
#    work.valid?.must_equal false
#    work.errors.must_include :title
#
#    work.title = "a" * 26
#    work.valid?.must_equal false
#    work.errors.must_include :title
#  end
#
#  it "must have an author" do
#    author = Author.create name: "Kari B"
#
#    work.author = author
#    work.author_id.must_equal author.id
#  end
#
#  it "must have a genre field" do
#    work.genres.must_equal []
#    work.genres << Genre.create(name: "Sci Fi")
#
#    genre = Genre.find_by name: "Sci Fi"
#    work.genres.must_include genre
#  end
