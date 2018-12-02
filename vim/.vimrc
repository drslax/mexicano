"autoclose
execute pathogen#infect()

"theme
filetype on
syntax on
color gruvbox
set guifont=Menlo\ Regular:h18
set number
set mouse=a

"set hlsearch
"set smartcase
"set incsearch

"A_C_code_is_automatically_indented_with_tabs
set autoindent
set cindent
set softtabstop=4

"Backup_files
set backup
set backupdir=~/.vim/.backup/
set undodir=~/.vim/.undo/
set directory=~/.vim/.swp/

"The_position_column_of_the_cursor_is_displayed
set ruler

"Two_side-by-side_spaces_are_highlighted
highlight	doublespace ctermbg=gray guibg=gray
match		doublespace /  /

"A_whitespace_before_a_line_break_is_highlighted
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=green guibg=green

"Header:

noremap <C-c><C-h> :call Header()<enter>

autocmd BufWritePre *.c :call Update()
autocmd BufNewFile *.c :call Header()

function! Update()
	if &modified
		return 0
	endif
	let date = strftime('%Y/%m/%d')
	let hour = strftime('%H:%M:%S')
	let updated = "/*   Updated: ".date." ".hour." by ".$USER
	let i = 17 - strwidth($USER)
	while i > 0
		let updated = updated . " "
		let i = i - 1
	endwhile
	let updated = updated . "###   ########.fr       */"
	call setline(9, updated)
endfunction

function! Header()

	let filename = "/*   ".expand('%:t')
	let i = 50 - strwidth(expand('%:t'))
	while i > 0
		let filename = filename . " "
		let i = i - 1
	endwhile
	let filename = filename . " :+:      :+:    :+:   */"

	if empty($MAIL)
		let mail = "marvin@42.fr"
	else
		let mail = $MAIL
	endif

	let author = "/*   By: ".$USER." <".mail.">"
	let authorlength = strwidth($USER) + strwidth(mail)
	let i = 40 - authorlength
	while i > 0
		let author = author . " "
		let i = i - 1
	endwhile
	let author = author . "+#+  +:+       +#+        */"

	let date = strftime('%Y/%m/%d')
	let hour = strftime('%H:%M:%S')
	let i = 18 - strwidth($USER)
	let created = "/*   Created: ".date." ".hour." by ".$USER
	while i > 0
		let created = created . " "
		let i = i - 1
	endwhile
	let created = created . "#+#    #+#             */"

	let updated = "/*   Updated: ".date." ".hour." by ".$USER
	let i = 17 - strwidth($USER)
	while i > 0
		let updated = updated . " "
		let i = i - 1
	endwhile
	let updated = updated . "###   ########.fr       */"

	:normal gg
	call append(0, "/* ************************************************************************** */")
	call append(1, "/*                                                                            */")
	call append(2, "/*                                                        :::      ::::::::   */")
	call append(3, filename)
	call append(4, "/*                                                    +:+ +:+         +:+     */")
	call append(5, author)
	call append(6, "/*                                                +#+#+#+#+#+   +#+           */")
	call append(7, created)
	call append(8, updated)
	call append(9, "/*                                                                            */")
	call append(10, "/* ************************************************************************** */")
endfunction

"a_bonus
let mapleader = ","
noremap <leader>d :source ~/.vimrc<cr>
noremap <leader>9 :wq<cr>
noremap <leader>6 :w<cr>
noremap <leader>3 :q<cr>
