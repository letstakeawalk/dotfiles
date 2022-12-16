-- jiangmiao/auto-pairs
vim.g.AutoPairsFlyMode = 1 -- default 0
vim.g.AutoPairsShortcutFastWrap = "<C-p>" -- default <A-e>
vim.g.AutoPairsShortcutJump = "<C-n>" -- default <A-n>
vim.g.AutoPairsShortcutBackInsert = "<C-f>" -- default <A-b>

-- FastWrap examble
-- a[(3|)]  input ] --> a[(3)]|
--
-- input
-- {
--   hello();|   input <C-p>
--   world();
-- }
-- output
-- {
--   hello();    input <C-p>
--   world();
-- }|
