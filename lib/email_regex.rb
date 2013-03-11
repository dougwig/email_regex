class EmailRegex
  # 
  # RFC822, obsolete and more lax in most cases
  # 
  # CTL         =  <any ASCII control           ; (  0- 37,  0.- 31.)
  # SPACE       =  <ASCII SP, space>            ; (     40,      32.)
  # specials    =  "(" / ")" / "<" / ">" / "@"  ; Must be in quoted-
  #             /  "," / ";" / ":" / "\" / <">  ;  string, to use
  #             /  "." / "[" / "]"              ;  within a word.
  # atom        =  1*<any CHAR except specials, SPACE and CTLs>
  #
  # qtext       =  <any CHAR excepting <">,     ; => may be folded "\" & CR, and including linear-white-space>
  # quoted-pair =  "\" CHAR                     ; may quote any char
  # quoted-string = <"> *(qtext/quoted-pair) <">; Regular qtext or quoted chars.
  # word        =  atom / quoted-string
  #
  # local-part  =  word *("." word)             ; uninterpreted
  #
  # domain-ref  =  atom                         ; symbolic reference
  # sub-domain  =  domain-ref / domain-literal
  # domain      =  sub-domain *("." sub-domain)
  #
  # addr-spec   =  local-part "@" domain        ; global address
  #

  ctl            = '\x00-\x1f'
  space          = ' '
  specials       = '\(\)\<\>\@\,\;\:\\\"\.\[\]'
  atom           = '[^' + ctl + space + specials + ']+?'
  dot_atom       = atom + '(?:\.' + atom + ')*'					 # in common use, allowed by RFC2822

  qtext          = '[^\"\`]+'
  quoted_pair    = '\\.'
  quoted_string  = '\"(?:' + qtext + '|' + quoted_pair + ')+?\"'
  word           = '(?:' + dot_atom  + '|' + quoted_string + ')'

  local_part     = word							                 # ignore word[.word]

  domain_ref     = dot_atom
  domain_literal = '\[' + atom + '(?:[\.\:]' + atom + ')*\]'       # only used for IPv4/IPv6 addresses
  sub_domain     = '(?:' + domain_ref + '|' + domain_literal + ')'
  domain         = sub_domain

  addr_spec      = local_part + '\@' + domain

  addr_ws        = '\s*(' + addr_spec + ')\s*'
  addr_list      = '^' + addr_ws + '(?:,' + addr_ws + ')*$'

  EMAIL_ADDRESS_REGEX = /#{addr_list}/
end
