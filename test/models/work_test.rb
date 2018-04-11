require "test_helper"

describe Work do

describe 'valid' do

  # Validate title -------------------------------------------------------------
  it "must have a title" do
    work = works(:hpbook)
    work.title = nil
    work.valid?.must_equal false
  end

  it "removes strips white space from title" do
    valid_new_work = Work.create(title: "foo bar         baz", category: "book")
    valid_new_work.valid?.must_equal true
    valid_new_work.title.must_equal "foo bar baz"

    invalid_new_work_one = Work.create(title: "foo    bar   baz", category: "book")
    invalid_new_work_one.valid?.must_equal false
    invalid_new_work_one.errors.must_include :title

    invalid_new_work_two = Work.create(title: "   foo bar baz", category: "book")
    invalid_new_work_two.valid?.must_equal false
  end

  it "must have a title of at least one char" do
    new_work = Work.create(title: "", category: "book")
    new_work.valid?.must_equal false
    new_work.errors.must_include :title

    new_work = Work.create(title: "         ", category: "book")
    new_work.valid?.must_equal false

    new_work = Work.create(title: "a", category: "book")
    new_work.valid?.must_equal true
  end

  it "must have a unique title in same category" do
    new_work = Work.create(title: works(:hpbook).title, category:
      works(:hpbook).category)
    new_work.valid?.must_equal false
    new_work.errors.must_include :title
    new_work.errors.messages[:title].must_equal ["fucked up title"]
  end

  it "must have a unique, case-insensitive title" do
    new_work_title = works(:hpbook).title
    new_work_title[0] = new_work_title.chr.swapcase
    new_work = Work.create(title: new_work_title, category:
      works(:hpbook).category)

    new_work.valid?.must_equal false
    new_work.errors.must_include :title
  end

  # Validate category ----------------------------------------------------------
  it "allow duplicate title in different category" do
    works(:hpbook).category.must_equal "book"
    new_work = Work.create(title: works(:hpbook).title, category: "album")
    new_work.valid?.must_equal true
  end

  it "does not allow an invalid category" do
    work = works(:bundo)

    work.category = "foo"
    work.valid?.must_equal false

    work.category = nil
    work.valid?.must_equal false

    work.category = "book\n"
    work.valid?.must_equal false
  end

  it "allows a valid category" do
    work = works(:bundo)
    %w[movie book album].each do |category_type|
      work.category = category_type
      work.valid?.must_equal true
    end
  end

  # Validate publication_year --------------------------------------------------
  it "can have a nil publication year" do
    work = works(:bundo)
    work.publication_year = nil
    work.valid?.must_equal true
  end

  it "can have a valid date" do
    work = works(:bundo)

    work.publication_year = Date.new(1949)
    work.valid?.must_equal true

    work.publication_year = Date.new(0000)
    work.valid?.must_equal true

    work.publication_year = Date.today
    work.valid?.must_equal true
  end

  it "sets non-Dates to nil for publication_year" do
    work = works(:bundo)

    work.publication_year = "foo"
    work.valid?.must_equal true
    work.publication_year.must_be_nil
  end

  it "cannot have a year after publication_year" do
    work = works(:bundo)

    work.publication_year = Date.today + 1.year
    work.valid?.must_equal false
  end

  it "cannot have an invalid date" do
    work = works(:bundo)

    work.publication_year = 1949
    work.valid?.must_equal false

    work.publication_year = 42.0
    work.valid?.must_equal false

    work.publication_year = -2004
    work.valid?.must_equal false
  end

end

  describe 'relations' do

   it "has a votes" do
     work = works(:hpbook)
     work.must_respond_to :votes
   end

   it 'updates with votes' do
     work = works(:hpbook)
     num_of_original_votes = work.votes.count
     puts work.votes.count
     original_votes_array = work.votes
     new_vote = Vote.create work: works(:hpbook), user: User.create(name: "Newbie")

     # Overkill but just making sure
     work.votes.last.must_equal new_vote
     work.votes.must_equal original_votes_array << new_vote
     work.votes.count.must_equal num_of_original_votes + 1
   end

  end

  describe 'get_vote_count' do

   it 'responds to get_vote_count' do
     works(:hpbook).must_respond_to :get_vote_count
   end

   it 'returns the number of votes' do
     # new_work_wtf = Work.create title: "wtf is up with this", category: "book"
     new_work_wtf = works(:novotesbook)
     #
     # puts "?????????"
     # puts new_work_wtf.votes.count
     new_work_wtf.get_vote_count.must_equal 0
     # puts "******"
     # puts new_work_wtf.votes.inspect
     # puts "******"

     Vote.create work: works(:novotesbook), user: users(:noupvotesuserone)
     Vote.create work: works(:novotesbook), user: users(:noupvotesusertwo)
     Vote.create work: works(:novotesbook), user: users(:noupvotesuserthree)
     Vote.create work: works(:novotesbook), user: users(:noupvotesuserfour)

     # puts "-------"
     # puts new_work_wtf.votes.inspect
     # puts "-------"
     # count_before.must_equal 0
     new_work_wtf.get_vote_count.must_equal 4
   end

   # it "resets" do
   #   # users(:noupvotesuserone).votes.count.must_equal 0
   # end
  end

end


#
#
# it "must have a title" do
#   book.author = Author.create name: "Kari B"
#
#   book.title = nil
#
#   book.valid?.must_equal false
#   book.errors.must_include :title
#
# end
#
# it "must have a title between 1 and 25 letters" do
#   book.author = Author.create name: "Kari B"
#
#   book.title = ""
#   book.valid?.must_equal false
#
#   book.title = "12345678901234567890123456"
#   book.valid?.must_equal false
#
# end
#
# it "must have an author" do
#   author =  Author.create name: "Kari B"
#
#   book.author = author
#
#   book.author_id.must_equal author.id
#
# end
#
# it "must have a genre field" do
#   book.genres.must_equal []
#   book.genres << Genre.create( name: "Sci Fi")
#
#   genre = Genre.find_by name: "Sci Fi"
#
#   book.genres.must_include genre
#
# end


# describe "first published" do
#   it "should return the earliest published book for the author with multiple books" do
#     book.author = Author.create name: "Kari B"
#     value(book).must_be :valid?
#   end
#
#   it "must have as title" do
#     book.author = Author.create name: "Kari B"
#     book.title = nil
#     book.valid?.must_equal false # must have a title
#     book.errors.must_include :title
#   end
#
#   it "must have title between 1 and 25 characters" do
#     book.author = Author.create name: "Kari B"
#     book.title = ""
#     book.valid?.must_equal false
#     book.errors.must_include :title
#
#     book.title = "a" * 26
#     book.valid?.must_equal false
#     book.errors.must_include :title
#   end
#
#   it "must have an author" do
#     author = Author.create name: "Kari B"
#
#     book.author = author
#     book.author_id.must_equal author.id
#   end
#
#   it "must have a genre field" do
#     book.genres.must_equal []
#     book.genres << Genre.create(name: "Sci Fi")
#
#     genre = Genre.find_by name: "Sci Fi"
#     book.genres.must_include genre
#   end
