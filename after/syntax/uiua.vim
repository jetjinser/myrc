" copied from https://github.com/Apeiros-46B/nvim/blob/main/after/syntax/uiua.vim

if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "uiua"
syn iskeyword a-z

syn keyword uiuaIdentifier e os Family Arch ExeExt DllExt Sep NumProcs MaxInt
syn match   uiuaIdentifier '\a\+!*'

" {{{ functions and modifiers
" constants
syn keyword uiuaNoadic eta pi tau inf[inity] rand[om] tag now
syn match   uiuaNoadic '[ηπ∞τ⚂]'

" monadic and dyadic pervasive functions
syn keyword uiuaPervasive not sig[n] abs[olute] sqr[t] sin[e] flo[or] cei[ling] rou[nd] add subtract multiply divide mod[ulus] pow[er] log[arithm] min[imum] max[imum] ata[ngent]
syn match   uiuaPervasive '[¬±`¯⌵√○⌊⌈⁅]\|!=\|<=\|>=\|[=≠<≤>≥+\-×*÷%◿ⁿₙ↧↥∠]'

" monadic non-pervasive functions
syn keyword uiuaMonadic len[gth] sha[pe] rang[e] fir[st] rev[erse] des[hape] bit[s] tran[spose] ris[e] fal[e] whe[re] cla[ssify] ded[uplicate] box unb[ox] bre[ak] wait recv tryrecv gen parse utf type
syn match   uiuaMonadic '[⧻△⇡⊢⇌♭⋯⍉⍏⍖⊚⊛⊝□⊔⎋↬]'

" dyadic non-pervasive functions
syn keyword uiuaDyadic joi[n] cou[ple] mat[ch] pic[k] sel[ect] res[hape] tak[e] dro[p] rot[ate] win[dows] kee[p] fin[d] mem[ber] ind[exof] ass[ert] send deal regex
syn match   uiuaDyadic '[⊂⊟≍⊡⊏↯↙↘↻◫▽⌕∊⊗⍤]'

" monadic modifiers
" gap, reach, and dip single-letter spellings aren't accounted for
" 1. it's not very useful since adjacent ones won't be highlighted
" 2. it'll get formatted anyways
syn keyword uiuaMonadicMod gap rea[ch] dip eac[h] row[s] dis[tribute] tri[bute] tab[le] cro[ss] rep[eat] reduce scan gro[up] par[tition] inv[ert] bot[h] pac[k] spawn
syn match   uiuaMonadicMod '[⋅⟜⊙∵≡∺≐⊞⊠⍥/⊕⊜\\⍘∩⊐]'

" non-monadic modifiers
syn keyword uiuaOtherMod lev[el] com[binate] do und[er] fil[l] fol[d] bra[cket] for[k] try if
syn match   uiuaOtherMod /[≑◳⍢⍜⬚∧⊓⊃⍣?]/

" ocean notation
syn keyword uiuaOcean ro[ck] surface de[ep] ab[yss] se[abed]
syn match   uiuaOcean /[⋄~≊≃∸]/
" }}}

" {{{ system functions
" defined in inverse order so precedence for e.g.
" &i and &ime, &s and &sc, etc. is correct

" modules
syn match   uiuaModuleSF   '&i'

syn match   uiuaDyadicSF   '\v\&(rs|rb|ru|w|fwa|ime|ae|tcpsrt|tcpswt|httpsw)'
syn match   uiuaMonadicSF  '\v\&(sl|s|pf|p|raw|var|runi|runc|cd|cl|fo|fc|fde|ftr|fe|fld|fif|fras|frab|fwa|imd|ims|gifd|gife|ad|ap|tcpl|tcpa|tcpc|tcpsnb|tcpaddr|invk)'
syn match   uiuaNoadicSF   '\v\&(sc|ts|args|asr)'
syn match   uiuaModifierSF '&ast'
" }}}

" {{{ literals
" numeric literal
syn match   uiuaNum 'NaN\|[¯`]\?\d\+\(\.\d\+\)\?\(e[¯`]\?\d\+\)\?'

" escape sequence and format placeholder
syn match   uiuaEsc contained /\\[\\'"_0nrt]/
syn match   uiuaFmt contained '_'

" character literal
syn match   uiuaChar '@.' contains=uiuaEsc

" string literal (plain, format, and multiline)
syn region  uiuaStr start='"' end='"' skip='\\"' contains=uiuaEsc
syn region  uiuaStr start='\$"' end='"' skip='\\"' contains=uiuaEsc,uiuaFmt
syn region  uiuaStr start='\$ ' end='$' contains=uiuaEsc,uiuaFmt
" }}}

" {{{ misc
" function signatures
syn match   uiuaSignature '|\d\+\(\.\d\+\)\?'

" function placeholders in custom modifiers
syn match   uiuaFunctionPlaceholder '\^\d\+\(\.\d\+\)\?'

" test scopes, <- assignments, and stranded arrays
syn match   uiuaFaded '^---$\|[←_]'

" debug functions
syn keyword uiuaDebug dump trac[e]
syn match   uiuaDebug '⸮'

" comments
syn match   uiuaComment '#.*$'
" }}}

" {{{ highlight groups
hi def link uiuaNoadic              Keyword
hi def link uiuaNoadicSF            Keyword
hi def link uiuaPervasive           Operator
hi def link uiuaMonadic             Function
hi def link uiuaMonadicSF           Function
hi def link uiuaDyadic              Identifier
hi def link uiuaDyadicSF            Identifier
hi def link uiuaMonadicMod          Type
hi def link uiuaOtherMod            Number
hi def link uiuaModifierSF          Type
hi def link uiuaOcean               String
hi def link uiuaModuleSF            Keyword

hi def link uiuaNum                 Number
hi def link uiuaEsc                 SpecialChar
hi def link uiuaChar                String
hi def link uiuaFmt                 Operator
hi def link uiuaStr                 String

hi def link uiuaSignature           Type
hi def link uiuaFunctionPlaceholder Keyword
hi def link uiuaDebug               Operator
hi def link uiuaFaded               Comment
hi def link uiuaComment             Comment
" }}}
