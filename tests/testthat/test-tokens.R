##
## tokens_hashed tests
##

test_that("nsyllable works as expected for tokens_hashed", {
    txt <- c(one = "super freakily yes",
             two = "merrily all go aerodynamic")
    toks <- tokenize(txt)
    toksh <- tokens(txt)
    classic <- nsyllable(toks)
    hashed <- nsyllable(toksh)
    expect_equal(classic, hashed)
})


test_that("tokens_wordstem works as expected for tokens_hashed", {

    txt <- c(one = "Eating eater eaters eats ate.",
             two = "Taxing taxes taxed my tax return.")
    toks <- tokenize(toLower(txt), removePunct = TRUE)
    toksh <- tokens(toLower(txt), removePunct = TRUE)
    classic <- tokens_wordstem(toks)
    hashed <- tokens_wordstem(toksh)
    expect_equivalent(classic, as.tokenizedTexts(hashed))
})

test_that("ngrams works as expected for tokens_hashed", {
    txt <- c(one = toLower("Insurgents killed in ongoing fighting."),
             two = "A B C D E")
    toks <- tokenize(txt, removePunct = TRUE)
    toksh <- tokens(txt, removePunct = TRUE)
    classic <- tokens_ngrams(toks, n = 2:3)
    hashed <- tokens_ngrams(toksh, n = 2:3)
    expect_equivalent(classic, as.tokenizedTexts(hashed))
})

test_that("skipgrams works as expected for tokens_hashed", {
    txt <- c(one = "insurgents killed in ongoing fighting")
    toks <- tokenize(txt)
    toksh <- tokens(txt)
    classic <- skipgrams(toks, n = 3, skip = 0:2, concatenator = " ")
    hashed <- skipgrams(toksh, n = 3, skip = 0:2, concatenator = " ")
    expect_equivalent(classic, as.tokenizedTexts(hashed))
})


test_that("as.tokens tokenizedTexts works as expected", {
    txt <- c(doc1 = "The first sentence is longer than the second.",
             doc2 = "Told you so.")
    toks <- tokenize(txt)
    toksh <- tokens(txt) 
    expect_equivalent(toksh, 
                      as.tokens(toks))
})

test_that("as.tokens list version works as expected", {
    txt <- c(doc1 = "The first sentence is longer than the second.",
             doc2 = "Told you so.")
    toksh <- tokens(txt) 
    toks <- tokenize(txt)
    attributes(toks) <- NULL
    names(toks) <- names(txt)
    expect_equal(class(toks), "list")
    expect_equivalent(toksh, 
                      as.tokens(toks))
})

test_that("tokens indexing works as expected", {
    toks <- tokens(c(d1 = "one two three", d2 = "four five six", d3 = "seven eight"))

    expect_equal(toks$d1, c("one", "two", "three"))
    expect_equal(toks[[1]], c("one", "two", "three"))
    
    expect_equal(as.list(toks["d2"]), list(d2 = c("four", "five", "six")))
    expect_equal(as.list(toks[2]), list(d2 = c("four", "five", "six")))
    
    # issue #370
    expect_equal(attr((toks[1]), "types"), c("one", "two", "three"))
    expect_equal(attr((toks[2]), "types"), c("four", "five", "six"))
})

test_that("tokens_hashed_recompile combine duplicates is working", {
    toksh <- tokens(c(one = "a b c d A B C D", two = "A B C d"))
    expect_equal(attr(toksh, "types"),
                 c("a", "b", "c", "d", "A", "B", "C", "D"))
    expect_equal(attr(tokens_tolower(toksh), "types"),
                 c("a", "b", "c", "d"))
    
    attr(toksh, "types") <- char_tolower(attr(toksh, "types"))
    expect_equal(attr(quanteda:::tokens_hashed_recompile(toksh), "types"),
                 c("a", "b", "c", "d"))
    
})


#' # coerce an object into a tokens class
#' as.tokens(toks)


#' \dontrun{
#' tokens2 <- tokenize(head(inaugTexts, 10), removePunct=TRUE)
#' tokens2_hashed <- hashTokens(tokens2)
#' 
#' profvis::profvis({
#' ngrams(tokens2_hashed, n = 2:3, skip = 1:2, concatenator = "-")
#' })
#' 
#' microbenchmark::microbenchmark(
#'  old=ngrams(tokens2, n = 2:3, skip = 1:2, concatenator = "-"),
#'  new=ngrams(tokens2_hashed, n = 2:3, skip = 1:2, concatenator = "-"),
#'  times=10, unit='relative'
#' )
#' 
#' 
#' Rcpp::sourceCpp('src/ngrams_hashed.cpp')
#' Rcpp::sourceCpp('src/ngrams_class.cpp')
#' Rcpp::sourceCpp('src/ngrams.cpp')
#' nm <- new(ngramMaker)
#'
#' microbenchmark::microbenchmark(
#'    old=skipgramcpp(tokens2[[1]], 2:3, 1:2, '-'),
#'    new=qatd_cpp_ngram_hashed_vector(tokens2_hashed[[1]], 2:3, 1:2),
#'    class=nm$generate(tokens2_hashed[[1]], 2:3, 1:2),
#'    times=100, unit='relative'
#' )
#' 
#' microbenchmark::microbenchmark(
#'  obj=nm$generate_list(tokens2_hashed, 2:3, 1:2),
#'  ptr=nm$generate_list_ptr(tokens2_hashed, 2:3, 1:2),
#'  times=100, unit='relative'
#' )
#' 
#' 
#' tokens3 <- rep(letters, 50)
#' types3 <- unique(tokens3)
#' tokens3_hashed <- match(tokens3, types3)
#' microbenchmark::microbenchmark(
#'    old=skipgramcpp(tokens3, 2:3, 1:2, '-'),
#'    new=qatd_cpp_ngram_hashed_vector(tokens3_hashed, 2:3, 1:2),
#'    times=10, unit='relative'
#'  )
#' 
#' # Test with greater lexical diversity
#' tokens4 <- paste0(sample(letters, length(tokens3), replace=TRUE), 
#'                   sample(letters, length(tokens3), replace=TRUE))
#' types4 <- unique(tokens4)
#' tokens4_hashed <- match(tokens4, types4)
#' microbenchmark::microbenchmark(
#'    low=qatd_cpp_ngram_hashed_vector(tokens3_hashed, 2:3, 1:2),
#'    high=qatd_cpp_ngram_hashed_vector(tokens4_hashed, 2:3, 1:2),
#'    times=100, unit='relative'
#' )
#' 
#' 
#' # Comparison with tokenizers's skip-grams
#' tokenizers::tokenize_skip_ngrams('a b c d e', n=3, k=1) 
#' # "a c e" "a b c" "b c d" "c d e"
#' tokenizers::tokenize_skip_ngrams('a b c d e', n=3, k=2) 
#' # "a c e" "a b c" "b c d" "c d e"
#' 
#' ngrams(tokenize('a b c d e'), n=3, skip=0:1, concatenator=' ') 
#' # "a b c" "a b d" "a c d" "a c e" "b c d" "b c e" "b d e" "c d e"
#' 
#'}

