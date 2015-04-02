#
# Title Caps
# 
# Ported to JavaScript By John Resig - http://ejohn.org/ - 21 May 2008
# Original by John Gruber - http://daringfireball.net/ - 10 May 2008
# Ported to CoffeeScript and improved by Calvin Correli - 2 April 2015
# License: http://www.opensource.org/licenses/mit-license.php
#

# List comes from here: http://lanecc.libguides.com/content.php?pid=38483&sid=295540
small = "(" + ["a","aboard","about","above","absent","across","after","against","along","alongside","amid","amidst","among","amongst","an","and","around","as","as","aslant","astride","at","athwart","atop","barring","before","behind","below","beneath","beside","besides","between","beyond","but","by","despite","down","during","except","failing","following","for","for","from","in","inside","into","like","mid","minus","near","next","nor","notwithstanding","of","off","on","onto","opposite","or","out","outside","over","past","per","plus","regarding","round","save","since","so","than","the","through","throughout","till","times","to","toward","towards","under","underneath","unlike","until","up","upon","via","v","v.", "vs", "vs.","when","with","within","without","worth","yet"].join("|") + ")"
punct = "([!\"#$%&'()*+,./:;<=>?@[\\\\\\]^_`{|}~-]*)"

lower = (word) ->
  word.toLowerCase()
    
capitalize = (word) ->
  word.substr(0,1).toUpperCase() + word.substr(1)

upper = (word) ->
  word.toUpperCase()
  
window.titleCaps = (title) ->
  parts = []
  split = /[:.;?!] |(?: |^)["Ò]/g
  index = 0
  
  while true
    m = split.exec(title)

    parts.push( 
      title.substring(index, if m then m.index else title.length)
      .replace(/\b([A-Za-z][a-z.'Õ]*)\b/g, (all) ->
        if /[A-Za-z]\.[A-Za-z]/.test(all) then all else capitalize(all)
      )
      .replace(RegExp("\\b" + small + "\\b", "ig"), lower)
      .replace(RegExp("^" + punct + small + "\\b", "ig"), (all, punct, word) ->
        punct + capitalize(word)
      )
      .replace(RegExp("\\b" + small + punct + "$", "ig"), capitalize))
    
    index = split.lastIndex
    
    if m
      parts.push(m[0])
    else
      break
  
  parts.join("")
    .replace(/ V(s?)\. /ig, " v$1. ")
    .replace(/(['Õ])S\b/ig, "$1s")
    .replace(/\b(AT&T|Q&A)\b/ig, upper)

String.prototype.toTitleCaps = ->
  titleCaps(this)
  
