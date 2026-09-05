
keywordColorPickerElement     = document.getElementById 'keyword-color-picker'
literalColorPickerElement     = document.getElementById 'literal-color-picker'
conjunctionColorPickerElement = document.getElementById 'conjunction-color-picker'

newTextArea                   = document.getElementById 'highlighted-text'

submitCodeButton              = document.getElementById 'submit-main-input'

registerNewKeywordButton      = document.getElementById 'submit-new-keyword-button'
registerNewConjunctionButton  = document.getElementById 'submit-new-conjunction-button'

keywordsListElement           = document.getElementById 'keywords-list'
conjunctionsListElement       = document.getElementById 'conjunctions-list'

clearOutputButton             = document.getElementById 'clear-highlighted-text'

removeKeywordButton           = document.getElementById 'submit-remove-keyword-button'
keywordToRemove               = document.getElementById 'remove-keyword'

removeConjunctionButton       = document.getElementById 'submit-remove-conjunction-button'
conjunctionToRemove           = document.getElementById 'remove-conjunction-textbox'

saveButton                    = document.getElementById 'save-registry'
loadButton                    = document.getElementById 'load-registry'
toggleDarkModeElement         = document.getElementById 'toggle-dark-mode'

keywordsList = []
conjunctionsList = []

darkMode = off

lex = (word) ->
  if word in keywordsList     then return 'keyword'
  if word in conjunctionsList then return 'conjunction'
  if word.match([/a-zA-Z0-9/])  then return 'literal' # refactor to support strings
  return 'other'

insertKeyword = (keyword) ->
  keywordColor = keywordColorPickerElement.value
  newTextArea.innerHTML += "<span style='color: #{keywordColor}'>#{keyword}</span> "
  console.log 'added new keyword'
  return

insertLiteral = (literal) ->
  literalColor = literalColorPickerElement.value
  newTextArea.innerHTML += "<span style='color: #{literalColor}'>#{literal}</span> "
  console.log 'added new literal'
  return

insertConjunction = (conjunction) ->
  conjunctionColor = conjunctionColorPickerElement.value
  newTextArea.innerHTML += "<span style='color: #{conjunctionColor}'>#{conjunction}</span> "
  console.log 'added new conjunction'
  return

insertOther = (word) ->
  console.log 'dark mode is:'
  console.log darkMode
  if darkMode == on
    newTextArea.innerHTML += "<span style='color: white'>#{word}</span> "
    return
  else
    newTextArea.innerHTML += "#{word} "
    console.log 'added new word'
  return


# basically the main function
highlightCode = () ->
  code = document.getElementById('main-input-text').value
  if code.length == 0
    console.log 'nothing to highlight'
    return

  if keywordsList.length == 0 and conjunctionsList.length == 0
    alert("You have no registered keywords or conjunctions; nothing will be highlighted.")
    return

  words = code.replace(/\n/g, ' NEWLINE ').split(/\s+/)
  for word in words
    console.log word
    token = lex word
    if word == 'NEWLINE'
      newTextArea.innerHTML += '<br>'
      continue
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
  if newConjunction in conjunctionsList
    alert("This conjunction is already registered: #{newConjunction}")
    return
  conjunctionsList.push newConjunction
  conjunctionsListElement.innerHTML += "<li>#{newConjunction}</li>"

removeKeyword = () ->
  unless keywordToRemove.value in keywordsList
    alert("The keyword #{keywordToRemove.value} is not registered.")
    return

  for keywordIterator in keywordsList
    if keywordIterator == keywordToRemove.value then keywordsList.splice keywordsList.indexOf(keywordIterator), 1

  keywords = Array.from keywordsListElement.getElementsByTagName('li')
  for keywordIterator in keywords
    if keywordIterator.innerHTML == keywordToRemove.value then keywordsListElement.removeChild keywordIterator

removeConjunction = () ->
  unless conjunctionToRemove.value in conjunctionsList
    alert("The conjunction #{conjunctionToRemove.value} is not registered.")
    return

  console.log 'fired removeConjunction'
  for conjunctionIterator in conjunctionsList
    if conjunctionIterator == conjunctionToRemove.value
      conjunctionsList.splice conjunctionsList.indexOf(conjunctionIterator), 1
      console.log 'removed conjunction from list'

  conjunctions = Array.from conjunctionsListElement.getElementsByTagName('li')
  for conjunctionIterator in conjunctions
    if conjunctionIterator.innerHTML == conjunctionToRemove.value
      conjunctionsListElement.removeChild conjunctionIterator
      console.log 'removed conjunction from html'

saveData = () ->
  data = {
    keywords: keywordsList
    conjunctions: conjunctionsList
  }
  localStorage.setItem 'data', JSON.stringify(data)
  console.log 'saved data'

loadData = () ->
  data = JSON.parse localStorage.getItem 'data'
  keywordsList = data.keywords
  conjunctionsList = data.conjunctions

  for keyword in keywordsList
    keywordsListElement.innerHTML += "<li>#{keyword}</li>"

  for conjunction in conjunctionsList
    conjunctionsListElement.innerHTML += "<li>#{conjunction}</li>"

  console.log 'loaded data'

toggleDarkMode = () ->
  if darkMode == off
    newTextArea.style.backgroundColor = "#191a1c"
    darkMode = on
    console.log 'dark mode is on'
  else
    newTextArea.style.backgroundColor = "white"
    darkMode = off
    console.log 'dark mode is off'

submitCodeButton.addEventListener 'click', () ->
  console.log 'clicked'
  highlightCode()

registerNewKeywordButton.addEventListener 'click', () ->
  registerKeyword()

registerNewConjunctionButton.addEventListener 'click', () ->
  registerConjunction()

clearOutputButton.addEventListener 'click', () ->
  newTextArea.innerHTML = ''

removeKeywordButton.addEventListener 'click', () ->
  removeKeyword()

removeConjunctionButton.addEventListener 'click', () ->
  removeConjunction()

saveButton.addEventListener 'click', () ->
  saveData()

loadButton.addEventListener 'click', () ->
  loadData()

toggleDarkModeElement.addEventListener 'click', () ->
  toggleDarkMode()