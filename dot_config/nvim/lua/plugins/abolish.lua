-- easily search, substitute, abbr multiple variants of a word
return {
    "tpope/vim-abolish",
    event = "InsertEnter",
    config = function()
        -- abbrs
        vim.cmd.abbr("bc", "because")
        vim.cmd.abbr("bw", "between")
        vim.cmd.abbr("b4", "before")
        vim.cmd.abbr("eg", "e.g.")
        vim.cmd.abbr("ie", "i.e.")
        vim.cmd.abbr("esp", "especially")
        vim.cmd.abbr("ftr", "for the record")
        vim.cmd.abbr("ppl", "people")
        vim.cmd.abbr("tho", "though")
        vim.cmd.abbr("wo", "without")
        vim.cmd.abbr("wrt", "with respect to")

        vim.cmd("Abolish {a,e,s,no}th             {any,every,some,no}thing")
        vim.cmd("Abolish {in,ex}cl{,s}            {}clude{}")
        vim.cmd("Abolish est{,d}                  estimate{}")
        vim.cmd("Abolish approp{,ly}              appropriate{}")
        vim.cmd("Abolish approx{,ly}              approximate{}")
        vim.cmd("Abolish thru{,put,out,ly}        through{}")
        vim.cmd("Abolish {s,h}ware{,s}            {soft,hard}ware{}")
        vim.cmd("Abolish {o,O,m,M}{to,2}{o,O,m,M} {one,One,many,Many}-{to}-{one,One,many,Many}")
        vim.cmd("Abolish altly                    alternatively")
        vim.cmd("Abolish decl{,ed,s}              declare{}")

        -- -- markdown only abbrs
        -- vim.api.nvim_create_autocmd("FileType", {
        --     group = vim.api.nvim_create_augroup("MarkdownAbolish", {}),
        --     pattern = { "markdown" },
        --     callback = function()
        --         vim.cmd("Abolish impl{,ed,s,tion} implement{,ed,s,ation}")
        --         vim.cmd("Abolish sys{,s} system{}")
        --     end,
        -- })

        -- too lazy to capitalize
        vim.cmd("Abolish Db               DB")
        vim.cmd("Abolish {,g}rpc          {}RPC")
        vim.cmd("Abolish nosql            NoSQL")
        vim.cmd("Abolish rdb{,ms}         RDB{,MS}")

        -- mis-caplitalization
        vim.cmd("Abolish BAs{e,ic}                      Bas{}")
        vim.cmd("Abolish EN{um,glish,gineer}            En{}")
        vim.cmd("Abolish HEllo                          Hello")
        vim.cmd("Abolish LI{fe,st,sts}                  Li{}")
        vim.cmd("Abolish IMplement{,ation,ed,s}         Implement{}")
        vim.cmd("Abolish INs{tant,pect}                 Ins{}")
        vim.cmd("Abolish INt{eger,erface,ernet}         Int{}")
        vim.cmd("Abolish NE{ovim,w,ver}                 Ne{}")
        vim.cmd("Abolish NO{ne,pe,te,thing}             No{}")
        vim.cmd("Abolish NU{ll,mber}                    Nu{}")
        vim.cmd("Abolish ON{ce,line,ly}                 On{}")
        vim.cmd("Abolish ST{actk,ore,yle}               St{}")
        vim.cmd("Abolish STr{ing,uct,eet}               Str{}")
        vim.cmd("Abolish OK Ok")

        -- common typos
        vim.cmd("Abolish archieve{,d,s}                       archive{}")
        vim.cmd("Abolish cal{a,e}nder{,s}                     cal{e}ndar{}")
        vim.cmd("Abolish cancelled                            canceled")
        vim.cmd("Abolish con{c,s}i{s,c}e                      con{c}i{s}e")
        vim.cmd("Abolish {,in}consistan{cy,cies,t,tly}        {}consisten{}")
        vim.cmd("Abolish defence{,es,less}                    defense{}")
        vim.cmd("Abolish delimeter{,s}                        delimiter{}")
        vim.cmd("Abolish despara{te,tely,tion}                despera{}")
        vim.cmd("Abolish d{e,i}screp{e,a}nc{y,ies}            d{i}screp{a}nc{}")
        vim.cmd("Abolish euphamis{m,ms,tic,tically}           euphemis{}")
        vim.cmd("Abolish {,non}existan{ce,t}                  {}existen{}")
        vim.cmd("Abolish functino                             function")
        vim.cmd("Abolish {fr}ei{nd}                           {}ie{}")
        vim.cmd("Abolish hense                                hence")
        vim.cmd("Abolish inherant{,ly}                        inherent{}")
        vim.cmd("Abolish {,un}nec{ce,ces,e}sar{y,ily}         {}nec{es}sar{}")
        vim.cmd("Abolish ona                                  on a")
        vim.cmd("Abolish persistan{ce,t,tly}                  persisten{}")
        vim.cmd("Abolish {,ir}releven{ce,cy,t,tly}            {}relevan{}")
        vim.cmd("Abolish rec{co,com,o}mend{,s,ed,ing,ation}   rec{om}mend{}")
        vim.cmd("Abolish reproducable                         reproducible")
        vim.cmd("Abolish seperat{e,es,ed,ing,ely,ion,ions,or} separat{}")
        vim.cmd("Abolish teh{,re,se,m,n,y}                    the{}")
        vim.cmd("Abolish tah{t,n}                             tha{}")
    end,
}
