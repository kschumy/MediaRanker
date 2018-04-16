require "test_helper"

describe Work do

# VALID ========================================================================
  describe 'valid' do

    # Validate title -----------------------------------------------------------
    it "must have a title" do
      work = works(:hpbook)
      work.title = nil
      work.valid?.must_equal false
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
      new_work.errors.messages[:title].must_equal ["has already been taken"]
    end

    it "must have a unique, case-insensitive title" do
      new_work_title = works(:hpbook).title
      new_work_title[0] = new_work_title.chr.swapcase
      new_work = Work.create(title: new_work_title, category:
        works(:hpbook).category)
      new_work.valid?.must_equal false
      new_work.errors.must_include :title
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

    it "allow duplicate title in different category" do
      new_work = Work.create(title: works(:hpbook).title, category: "album")
      new_work.valid?.must_equal true
    end

    # Validate category --------------------------------------------------------
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

    # Validate publication_year ------------------------------------------------
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

      work.publication_year = 42.0
      work.valid?.must_equal false

      work.publication_year = -2004
      work.valid?.must_equal false
    end

    it "cannot have a year after publication_year" do
      work = works(:bundo)

      work.publication_year = Date.today + 1.year
      work.valid?.must_equal false
    end

    # Validate description -----------------------------------------------------
    it "has a description" do
      work = Work.create(title: "foo", description: "hello", category: "book")
      work.valid?.must_equal true
      work.description.must_equal "hello"
    end

    it "removes white space from description" do
      work = Work.create(title: "foo", description: "    ", category: "book")
      work.valid?.must_equal true
      work.description.must_be_nil

      work.description = "    world"
      work.valid?.must_equal true
      work.description.must_equal "world"

      work.description = "hello    world"
      work.valid?.must_equal true
      work.description.must_equal "hello world"

      work.description = ""
      work.valid?.must_equal true
      work.description.must_be_nil
    end

    it "allow for description to be nil" do
      work = Work.create(title: "foo", category: "book")
      work.valid?.must_equal true
      work.description.must_be_nil
    end

    # Validate creator ---------------------------------------------------------
    it "has a creator" do
      work = Work.create(title: "foo", creator: "Bob", category: "book")
      work.valid?.must_equal true
      work.creator.must_equal "Bob"
    end

    it "removes strips white space from creator" do
      work = Work.create(title: "foo", creator: "    ", category: "book")
      work.creator = "    "
      work.valid?.must_equal true
      work.creator.must_be_nil

      work.creator = "    Builder"
      work.valid?.must_equal true
      work.creator.must_equal "Builder"

      work.creator = "Bob    the    Builder  "
      work.valid?.must_equal true
      work.creator.must_equal "Bob the Builder"

      work.creator = ""
      work.valid?.must_equal true
      work.creator.must_be_nil
    end

    it "allow for creator to be nil" do
      work = Work.create(title: "foo", category: "book")
      work.valid?.must_equal true
      work.creator.must_be_nil
    end

  end

# RELATIONS ====================================================================
  describe 'relations' do

    it "has a votes" do
      work = works(:hpbook)
      work.must_respond_to :votes
    end

    it 'updates with new votes' do
      work = works(:hpbook)
      num_of_original_votes = work.votes.count
      original_votes_array = work.votes
      new_vote = Vote.create work: works(:hpbook), user: User.create(name: "foo")

      # Overkill but just making sure
      work.votes.last.must_equal new_vote
      work.votes.must_equal original_votes_array << new_vote
      work.votes.count.must_equal num_of_original_votes + 1
    end

  end

# GET VOTE COUNT ===============================================================
  describe 'get_vote_count' do

    it 'responds to get_vote_count' do
      works(:hpbook).must_respond_to :get_vote_count
    end

    it 'returns the number of votes' do
      new_work = works(:novotesbook)
      new_work.get_vote_count.must_equal 0

      Vote.create work: works(:novotesbook), user: users(:noupvotesuserone)
      Vote.create work: works(:novotesbook), user: users(:noupvotesusertwo)
      Vote.create work: works(:novotesbook), user: users(:noupvotesuserthree)
      Vote.create work: works(:novotesbook), user: users(:noupvotesuserfour)

      new_work.get_vote_count.must_equal 4
    end

  end

  # GET PUBLICATION YEAR =======================================================
  describe "get_publication_year" do
    it "responds to get_publication_year" do
      works(:hpbook).must_respond_to :get_publication_year
    end

    it "gives the correct publication year" do
      year_published = works(:hpbook).publication_year.year
      works(:hpbook).get_publication_year.must_equal year_published
    end

    it "updates with publication_year changes" do
      work = works(:hpbook)
      original_year = work.get_publication_year

      work.publication_year -= 1.year
      work.get_publication_year.must_equal original_year - 1
    end

    it "can be nil" do
      work = works(:hpbook)
      work.publication_year = nil
      work.get_publication_year.must_be_nil
    end
  end

  # GET TOP IN ALL CATEGORIES SORTED ===========================================
  describe "get_top_overall" do
   # For reasons I don't understand but I'm guessing have something to do
   # cache/yml and testing (or I'm just completely doing this wrong), I have
   # to manually load these for counter cache to work

    it "must respond to get_top_in_all_categories_sorted" do
      Work.must_respond_to :get_top_in_all_categories_sorted
    end

    it "throws argument error if provided invalid num" do
      proc {
        Work.get_top_in_all_categories_sorted(num: "foo")
      }.must_raise ArgumentError
    end

    it "return num of results" do
      Vote.create(work: works(:novotesbook), user: users(:ada))
      Vote.create(work: works(:novotesbook), user: users(:lovelace))
      Vote.create(work: works(:novotesbooktwo), user: users(:mcuser))

      expected_results = {
        "album" => [works(:damn)],
        "book" => [works(:novotesbook), works(:novotesbooktwo)],
        "movie" => [works(:hpmovie)] }

      votes_hash = Work.get_top_in_all_categories_sorted(num: 2)
      votes_hash.must_equal expected_results
    end

    it "returns all with no num provided" do
      Vote.create(work: works(:novotesbook), user: users(:ada))
      Vote.create(work: works(:novotesbook), user: users(:lovelace))
      Vote.create(work: works(:novotesbooktwo), user: users(:mcuser))

      expected_results = {
        "album" => [works(:damn)],
        "book" => [ works(:novotesbook), works(:novotesbooktwo),
          works(:givingtree), works(:hpbook), works(:bundo)],
        "movie" => [works(:hpmovie)] }

      votes_hash = Work.get_top_in_all_categories_sorted
      votes_hash.must_equal expected_results
    end
  end

  # GET TOP OVERALL ===========================================================
  describe "get_top_overall" do
   # For reasons I don't understand but I'm guessing have something to do
   # cache/yml and testing (or I'm just completely doing this wrong), I have
   # to manually load these for counter cache to work

    it "must respond to get_top_overall" do
      Work.must_respond_to :get_top_overall
    end

    it "return the expected results" do
      Vote.create(work: works(:novotesbook), user: users(:ada))
      Vote.create(work: works(:novotesbook), user: users(:lovelace))
      Vote.create(work: works(:novotesbooktwo), user: users(:mcuser))

      expected_results = works(:novotesbook)

      results = Work.get_top_overall
      results.must_equal expected_results
    end

  end

  

  # # GET TOP IN CATEGORY SORTED =================================================
  #
  # ** METHOD NOT USED IN CURRENT VERSION OF PROGRAM **
  #
  # describe "get_top_in_category_sorted" do
  #   it "responds to get_top_in_category_sorted" do
  #     Work.must_respond_to :get_top_in_category_sorted
  #   end
  #
  #   it "throws argument error if provided invalid category" do
  #     proc { Work.get_top_in_category_sorted("foo", num: 2) }.must_raise ArgumentError
  #     proc { Work.get_top_in_category_sorted(num: 2) }.must_raise ArgumentError
  #   end
  #
  #   it "throws argument error if provided invalid num" do
  #     proc { Work.get_top_in_category_sorted("book", num: "foo") }.must_raise ArgumentError
  #   end
  # end




end
