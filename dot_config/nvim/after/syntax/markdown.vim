" disable unwanted default syntax
syn clear markdownError
syn clear markdownLinkText
syn clear markdownCode
syn clear markdownHeadingRule
syn clear markdownH1
syn clear markdownH2
syn clear markdownH3
syn clear markdownH4
syn clear markdownH5
syn clear markdownH6

" markdownWikiLink is a new region
syn region markdownWikiLink matchgroup=markdownLinkDelimiter start="\[\[" end="\]\]" contains=markdownUrl,markdownAliasedWikiLink keepend oneline concealends
" markdownAliasedWikiLink is a new region
syn match markdownAliasedWikiLink "[^\[\]]\+|" contained conceal
" markdownLinkText is copied from runtime files with 'concealends' appended
syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends
" markdownLink is copied from runtime files with 'conceal' appended
syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal
" highlight
syn region markdownHighlight matchgroup=markdownHighlightDelimiter start=/==/ end=/==/ concealends contains=markdownLineStart,@Spell
syn match markdownHighlightDelimiter contained containedin=markdownHighlight /\v\w+\s*/
hi markdownHighlightDelimiter guibg=#5C724A
" TODO: task tags
