return {
    settings = {
        ["harper-ls"] = {
            linters = {
                SpellCheck = false, -- refer to codebook ls
                Dashes = false, -- lua comment
                ToDoHyphen = false, -- todo comments
                Spaces = false, -- general styling
                EllipsisLength = false, -- lua string concat ..

                ExpandMinimum = false, -- min()
                ExpandArgument = false, -- args is common
                ExpandTimeShorthands = false, -- min, mins, hr, hrs, sec
                ExpandMemoryShorthands = false, -- KB, MB, etc
                ExpandStandardInputAndOutput = false, -- stdin, stdout
                ExpandDependencies = false, -- deps
                PunctuationClusters = false, -- punctuation !@#$ syntax
                CapitalizePersonalPronouns = false, -- i for index
                LongSentences = false, -- code is generally long
                SentenceCapitalization = false,
            },
        },
    },
}
