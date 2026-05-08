" navigate visual lines
nmap j gj
nmap k gk

" beginning/end of line
nmap H ^
nmap L $

" remove search highlights
nmap <F9> :nohl<CR>

" yank to system clipboard
set clipboard=unnamed

" back and forward with Ctrl+O and Ctrl+I
exmap back obcommand app:go-back
nmap <C-o> :back<CR>
exmap forward obcommand app:go-forward
nmap <C-i> :forward<CR>

" window and tabs
nmap <C-w>h :obcommand<space>workspace:split-horizontal<CR>
exmap tabnext obcommand workspace:next-tab
nmap gt :tabnext<CR>
exmap tabprev obcommand workspace:previous-tab
nmap gT :tabprev<CR>
