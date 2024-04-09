- Examples

`git rebase {{base_branch}} [{{topic_branch}}]`
`.`
`.  A---B---C---D  main`
`.       \`
`.        E---F---G  on topic {{(*)}}`
`.`
`. $ git switch topic && git rebase main  {{OR}}`
`. $ git rebase main topic`
`.`
`.  A---B---C---D  main`
`.               \`
`.                E'---F'---G'  topic`
`.`
`. $ git switch main && git merge topic   (fast-forward merge)`
`.`
`.  A---B---C---D---E'---F'---G' main, topic`


`git rebase --onto {{new_base}} {{old_base}} [{{target}}]`
`.`
`. A---B---C---D---E  main`
`.          \`
`.           F---G---H---I---J  server`
`.                \`
`.                 K---L---M  on client {{(*)}}`
`.`
`. $ git rebase --onto main server [client]`
`.`
`.                   K'---L'---M'  client`
`.                  /`
`. A---B---C---D---E  main`
`.          \`
`.           F---G---H---I---J  server`
`.`
`. $ git switch main && git merge client`
`.`
`. A---B---C---D---E---K'---L'---M'  main, client`
`.          \`
`.           F---G---H---I---J  server`
`.`
`. $ git rebase main server`
`.`
`. A---B---C---D---E---K'---L'---M'---F'---G'---H'---I'---J' server`
`.                                \`
`.                                 main, client`
`.`
`. $ git switch main && git merge server`
