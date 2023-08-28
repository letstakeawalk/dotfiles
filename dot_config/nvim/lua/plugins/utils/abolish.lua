-- easily search, substitute, abbr multiple variants of a word
return {
    "tpope/vim-abolish",
    event = "InsertEnter",
    config = function()
        -- abbrs
        vim.cmd.abbr("bc", "because")
        vim.cmd.abbr("bw", "between")
        vim.cmd.abbr("b4", "before")
        vim.cmd.abbr("esp", "especially")
        vim.cmd.abbr("tho", "though")
        vim.cmd.abbr("thru", "through")
        vim.cmd.abbr("ppl", "people")
        vim.cmd.abbr("wrt", "with respect to")
        vim.cmd.abbr("ftr", "for the record")
        vim.cmd("Abolish {any,some,no}th {}thing")
        vim.cmd("Abolish {in,ex}cl{,s} {}clude{}")
        vim.cmd("Abolish est{,d} estimate{}")
        vim.cmd("Abolish approx{,ly} approximate{}")

        -- mis-caplitalization
        vim.cmd("Abolish BAs{e,ic}                      Bas{}")
        vim.cmd("Abolish EN{um,glish,gineer}            En{}")
        vim.cmd("Abolish HEllo                          Hello")
        vim.cmd("Abolish LIst                           List")
        vim.cmd("Abolish IMplement{,ation,s}            Implement{}")
        vim.cmd("Abolish IN{teger,terface,ternet,spect} In{}")
        vim.cmd("Abolish NE{ovim,w,ver}                 Ne{}")
        vim.cmd("Abolish NO{ne,te,thing}                No{}")
        vim.cmd("Abolish NU{ll,mber}                    Nu{}")
        vim.cmd("Abolish ONline                         Online")
        vim.cmd("Abolish ST{ring,ruct,reet,ore,yle}     St{}")

        -- common typos
        vim.cmd("Abolish archieve{,d,s}                       archive{}")
        vim.cmd("Abolish teh{,re,se,m,n,y}                    the{}")
        vim.cmd("Abolish tah{t,n}                             tha{}")
        vim.cmd("Abolish {fr}ei{nd}                           {}ie{}")
        vim.cmd("Abolish cal{a,e}nder{,s}                     cal{e}ndar{}")
        vim.cmd("Abolish con{c,s}i{s,c}e                      con{c}i{s}e")
        vim.cmd("Abolish {,in}consistan{cy,cies,t,tly}        {}consisten{}")
        vim.cmd("Abolish delimeter{,s}                        delimiter{}")
        vim.cmd("Abolish cancelled                            canceled")
        vim.cmd("Abolish despara{te,tely,tion}                despera{}")
        vim.cmd("Abolish {,non}existan{ce,t}                  {}existen{}")
        vim.cmd("Abolish despara{te,tely,tion}                despera{}")
        vim.cmd("Abolish d{e,i}screp{e,a}nc{y,ies}            d{i}screp{a}nc{}")
        vim.cmd("Abolish euphamis{m,ms,tic,tically}           euphemis{}")
        vim.cmd("Abolish hense                                hence")
        vim.cmd("Abolish inherant{,ly}                        inherent{}")
        vim.cmd("Abolish {,un}nec{ce,ces,e}sar{y,ily}         {}nec{es}sar{}")
        vim.cmd("Abolish persistan{ce,t,tly}                  persisten{}")
        vim.cmd("Abolish {,ir}releven{ce,cy,t,tly}            {}relevan{}")
        vim.cmd("Abolish rec{co,com,o}mend{,s,ed,ing,ation}   rec{om}mend{}")
        vim.cmd("Abolish reproducable                         reproducible")
        vim.cmd("Abolish seperat{e,es,ed,ing,ely,ion,ions,or} separat{}")
    end,
}
