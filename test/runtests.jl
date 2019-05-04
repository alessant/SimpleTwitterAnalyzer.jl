using Test, DataFrames
using SimpleTwitterAnalyzer

#setup code

@testset "IO" begin
	#A simplified version of some tweets,
	#showing how different kinds of data returned by Twitter
	#are actually represented into the df
	fname = "testdata/io.json"
	loaded_df = loadtweets(fname)
	test_df = DataFrame(
		:created_at => ["Mon Apr 29 15:37:57 +0000 2019", "Mon Apr 29 16:45:43 +0000 2019", "Mon Apr 29 17:18:21 +0000 2019"],
		:entities => [
			Dict{String, Any}("user_mentions" => Any[Dict{String, Any}("screen_name" => "Quedusse")], "hashtags" => Any[Dict{String, Any}("text"=>"GameOfThrones")]),
			Dict{String, Any}("user_mentions" => Any[], "hashtags" => Any[Dict{String,Any}("text"=>"GameOfThrones")]),
			Dict{String, Any}("user_mentions"  => Any[], "hashtags" => Any[Dict{String,Any}("text"=>"NotToday")])
		],
		:id => [1122867622738124801, 1122867622738124802, 1122867622738124803],
		:is_quoted_status => [false, false, true]
	)
	@test test_df.created_at == loaded_df.created_at
	@test test_df.id == loaded_df.id
	@test test_df.entities == loaded_df.entities
	@test test_df.is_quoted_status == loaded_df.is_quote_status
end;

# path = "testdata/test.json"
# tweetsdf = loadtweets(path)

# @testset "Analyses" begin
# 	#lang distribution
# 	testdf = DataFrame(:lang => ["pt", "en", "es"], :cnt => [3, 9, 1])
# 	@test cntoccurences(tweetsdf, :lang) == testdf
#
# 	#source distribution
# 	#testdf = DataFrame(:source => ["<a href="http://twitter.com/download/iphone" rel="nofollow">Twitter for iPhone</a>"])
# 	#@test_throws DomainError (-1)^0.5
# end;
