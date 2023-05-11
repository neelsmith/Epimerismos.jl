struct Sentence
   tokens::Vector{Tuple{CitablePassage, TokenCategory}}
end


"""Parse all tokens in sentence `s` with Kanones parser `p`,
and return a vector of `AnalyzedToken`s.
"""
function parsesentence(s::Sentence, p::KanonesParser)
    map(s.tokens) do t
        parsepassage(t[1], p)
    end
end

#=
function sentences(c::CitableTextCorpus)
end
function sentences(psgs::Vector{CitablePassage})
end


"""Segment `tkns` into vectors corresponding to sentences.
"""
function sentences(tkns::Vector{AnalyzedToken})
    @warn("TBD")
    nothing
end
=#


"""Segment `tkns` into vectors corresponding to sentences.
This `tkns` parameter is what comes out of `tokenize` a corpus.
"""
function sentences(tkns::Vector{Tuple{CitablePassage, TokenCategory}}; terminators = [".", ";", ":"])
    @info("Parsing $(length(tkns)) into sentences")
    sentencelist = Sentence[]
    currenttokens = Tuple{CitablePassage, TokenCategory}[]
    for (tkn,tkntype) in tkns
        push!(currenttokens, (tkn,tkntype))
        if tkn.text in terminators
            push!(sentencelist, Sentence(currenttokens))
            currenttokens = Tuple{CitablePassage, TokenCategory}[]
        end
    end
    sentencelist
end