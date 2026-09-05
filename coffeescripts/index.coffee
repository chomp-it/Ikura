
keywordColorPickerElement     = document.getElementById 'keyword-color-picker'
literalColorPickerElement     = document.getElementById 'literal-color-picker'
conjunctionColorPickerElement = document.getElementById 'conjunction-color-picker'

keywordColor = keywordColorPickerElement.value
literalColor = literalColorPickerElement.value
conjunctionColor = conjunctionColorPickerElement.value

newTextArea                  = document.getElementById 'highlighted-text'

submitCodeButton             = document.getElementById 'submit-main-input'

registerNewKeywordButton     = document.getElementById 'submit-new-keyword-button'
registerNewConjunctionButton = document.getElementById 'submit-new-conjunction-button'

keywordsListElement          = document.getElementById 'keywords-list'
conjunctionsListElement      = document.getElementById 'conjunctions-list'

keywordsList = []
conjunctionsList = []

lex = (word) ->
  if word in keywordsList     then return 'keyword'
  if word in conjunctionsList then return 'conjunction'
  if word.match(/a-zA-Z0-9/)  then return 'literal' # refactor to support strings
  return 'other'

insertKeyword = (keyword) ->
  newTextArea.value += "<span style='color: #{keywordColor}'>#{keyword}</span>}"
  console.log 'added new keyword'
  return

insertLiteral = (literal) ->
  newTextArea.value += "<span style='color: #{literalColor}'>#{literal}</span>}"
  console.log 'added new literal'

insertConjunction = (conjunction) ->
  newTextArea.value += "<span style='color: #{conjunctionColor}'>#{conjunction}</span>}"
  console.log 'added new conjunction'

insertOther = (word) ->
  newTextArea.value += word
  console.log 'added new word'


# basically the main function
highlightCode = () ->
  code = document.getElementById('main-input-text').value
  if code.length == 0
    console.log 'nothing to highlight'
    return

  words = code.split(' ')
  for word in words
    console.log word
    token = lex word
    if token == 'keyword'     then insertKeyword(word)
    if token == 'literal'     then insertLiteral(word)
    if token == 'conjunction' then insertConjunction(word)
    if token == 'other'       then insertOther(word)

registerKeyword = () ->
  newKeyword = document.getElementById('add-keyword').value
  if newKeyword.length == 0
    alert("The textbox is empty")
    return
  if newKeyword in keywordsList
    alert("This keyword is already registered: #{newKeyword}")
    return
  keywordsList.push newKeyword
  keywordsListElement.innerHTML += "<li>#{newKeyword}</li>"

registerConjunction = () ->
  newConjunction = document.getElementById('add-conjunction').value
  if newConjunction.length == 0
    alert("The textbox is empty")
    return
  if newConjunction in keywordsList
    alert("This conjunction is already registered: #{newConjunction}")
    return
  conjunctionsList.push newConjunction
  conjunctionsListElement.innerHTML += "<li>#{newConjunction}</li>"

submitCodeButton.addEventListener 'click', () ->
  console.log 'clicked'
  highlightCode()

registerNewKeywordButton.addEventListener 'click', () ->
  registerKeyword()

registerNewConjunctionButton.addEventListener 'click', () ->
  registerConjunction()


