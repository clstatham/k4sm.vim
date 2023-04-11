" Vim syntax file
" Language:     K4SM (k4s assembly) syntax for VIM
" Maintainer:   Connor Statham
" Last Change:  2023 Apr 11
" Version:      0.01
" Remark:       Forked from gas.vim by Shirk @ github
" License:      BSD (3 clause), see LICENSE
"

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

setlocal iskeyword +=%,.,-,_

syn case ignore

" symbols and labels
" - these need to appear at the top to get lowest precedence

syn match   k4smLabel		/%[-_$.A-Za-z0-9]\+\s*/
syn match   k4smSymbol		/\<[^; \t()]\+\>/
syn match   k4smSymbolRef	/\$[-_$.A-Za-z][-_$.A-Za-z0-9]*\>/
syn match   k4smSpecial		/\<[$.]\>/

" constants
syn region  k4smString		start=/"/  end=/"/ skip=/\\"/
syn match   k4smCharacter	/'\(?\|\\?\)/
syn match   k4smDecimalNumber	/\$\?-\?\d\+/
syn match   k4smBinaryNumber	/\$\?-\?0b[01]\+/
syn match   k4smOctalNumber	/\$\?-\?0\d\+/
syn match   k4smHexNumber	/\$\?-\?0x\x\+/
" -- TODO: k4smFloatNumber

" directives
syn keyword k4smDirective	include ent


syn keyword k4smDirectiveStore	i8 i16 i32 i64 i128 f32 f64
syn keyword k4smDirectiveStore  align1 align2 align4 align8 align16 align32 align64

syn keyword k4smRegister        ra rb rc rd re rf rg rh ri rj rk rl rz bp sp pc fl

syn keyword k4smOpcode          nop und hlt mov push pop printi printc add sub mul
syn keyword k4smOpcode          div sdiv mod smod and or xor cmp scmp jmp jgt jlt
syn keyword k4smOpcode          jge jle jeq jne juno junoeq junone junogt junolt
syn keyword k4smOpcode          junole junoge jord jordeq jordne jordlt jordgt
syn keyword k4smOpcode          jordle jordge call ret shl shr sshr sext

" comments etc.
syn match   k4smOperator		/[+-/*=|&~<>]\|<=\|>=\|<>/
syn match   k4smTODO		/\<\(TODO\|FIXME\|NOTE\)\>/ contained
syn region  k4smCommentSingle    start=/;/ end=/$/ contains=k4smTODO

" link to defaults
hi def link k4smDirective	Preproc
hi def link k4smDirectiveStore	Type
hi def link k4smRegister	Identifier
hi def link k4smString		String
hi def link k4smCharacter	Character
hi def link k4smBinaryNumber	Constant
hi def link k4smOctalNumber	Constant
hi def link k4smHexNumber	Constant
hi def link k4smDecimalNumber	Constant
hi def link k4smSymbol		Function
hi def link k4smSymbolRef	Special
hi def link k4smSpecial		Special
hi def link k4smLabel		Function
hi def link k4smLocalLabel	Label
hi def link k4smOperator	Operator
hi def link k4smTODO		Todo
hi def link k4smOpcode		Keyword
hi def link k4smComment		Comment
hi def link k4smCommentSingle	Comment

"-- initial mapping => Keyword
func! s:MapOpcode (group)
	let himap = 'Keyword'

	exe 'hi link '.a:group.' '.himap
endf


" finishing touches
let b:current_syntax = "k4sm"

syn sync ccomment
syn sync linebreaks=1

" vim: ts=8 sw=8 :

