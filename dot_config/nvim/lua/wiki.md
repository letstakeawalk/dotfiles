<!-- TODO: move this to neorg -->

# Wiki

## Keymaps

### Normal mode

### Insert mode

### Commandline mode

### Visual & Select mode

### Operator-pending mode

| key | desc | usage | example |
| --- | ---- | ----- | ------- |

- `r`: remote (leap-spooky) -- `{cmd}{ai}r{obj}<leap>`: delete around word from leaping
- `g`: magnet (leap-spooky) -- `{cmd}{ai}g{obj}<leap>`: delete around magnet word from leaping
- `n`: next (mini.ai) -- `{cmd}{ai}n{obj}`: delete around next bracket
- `l`: last (mini.ai) -- `{cmd}{ai}l{obj}`: delete around last bracket

### Text Objects

| key | object      | source                           |
| --- | ----------- | -------------------------------- |
| a   | param/arg   | treesitter                       |
| b   | bracket     | builtin                          |
| c   | class       | treesitter                       |
| d   | conditional | treesitter                       |
| e   |             |
| f   | function    | treesitter                       |
| g   | magnet      | leap-spooky                      |
| gg  | magnet line | leap-spooky                      |
| h   |             |
| i   |             |
| j   |             |
| k   | block       | treesitter                       |
| l   | last        | mini.ai                          |
| L   | loop        | treesitter                       |
| m   | comment     | treesitter                       |
| n   | next        | mini.ai                          |
| o   | loop        | treesitter                       |
| p   | paragraph   | builtin                          |
| q   | quote       | builtin                          |
| r   | remote      | leap-spooky                      |
| rr  | remote line | leap-spooky                      |
| s   | sentence    | builtin?                         |
| t   | tag         | mini.ai ? builtin ? treesitter ? |
| u   |             |
| v   |             |
| w   |             |
| x   |             |
| y   |             |
| z   |             |

### Goto

)( function outer
]a mini.ai
[a mini.ai
[s builtin
]s builtin

arst arstarst
arst arstarst
