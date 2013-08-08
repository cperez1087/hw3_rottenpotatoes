
# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  #Movie.delete_all

  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.

    Movie.create!(movie)
  end

end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  assert page.body =~ /#{e1}.+#{e2}/m

end

Then /I should see (all)?(none)? of the movies/ do |see_all, see_none|
  row_count = 0
  movies = Movie.all.map(&:title)
  page_movies = page.all('table#movies tbody tr')

  if(see_all)
    page_movies.count.should == movies.length
    #assert_equal page_movies.count, movies.length
    movies.each do |movie|
      step %{I should see "#{movie}"}
    end
  elsif (see_none)
    #assert_equal page_movies.count, 0
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(",")

  ratings.each do |rating|
    step %{I #{uncheck ? 'uncheck' : 'check'} "ratings_#{rating.strip}"}
  end
end


