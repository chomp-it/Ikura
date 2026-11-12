
newTextArea              = document.getElementById 'highlighted-text'

keywordsListElement      = document.getElementById 'keywords-list'
conjunctionsListElement  = document.getElementById 'conjunctions-list'

keywordToRemove          = document.getElementById 'remove-keyword'
conjunctionToRemove      = document.getElementById 'remove-conjunction'

hideKeywordListButton    = document.getElementById 'hide-keywords'
hideConjunctionListButton= document.getElementById 'hide-conjunctions'

keywordsList     = []
conjunctionsList = []
darkMode       = off

# replace curly quotes (single or double) with straight quotes
cleanUp = (text) ->
  text.replace(/[“]/g, '"').replace /[’]/g, "'"

literalRegex = /^[^a-zA-Z0-9]*[a-zA-Z0-9]+[^a-zA-Z0-9]*$/
lex = (word) ->
  if word in keywordsList          then 'keyword'
  else if word in conjunctionsList then 'conjunction'
  else if word.match literalRegex  then 'literal'
  else 'other'

insertOther = (word) ->
  color = if darkMode is on then 'white' else 'inherit'
  newTextArea.innerHTML += "<span style='color: #{color}'>#{word}</span> "

insertToken = (token, colorPickerId) ->
  color = document.getElementById(colorPickerId).value
  newTextArea.innerHTML += "<span style='color: #{color}'>#{token}</span> "

# basically the main function
highlightCode = ->
  code = document.getElementById('main-input-text').value
  if code.length is 0 then return

  if keywordsList.length is 0 and conjunctionsList.length is 0
    alert "You have no registered keywords or conjunctions; nothing will be highlighted."
    return

  code = cleanUp code

  words = code.replace(/\n/g, ' NEWLINE ').replace(/  /g, ' INDENT ').split /\s+/
  for word in words
    if word is 'NEWLINE'
      newTextArea.innerHTML += '<br>'
      continue
    if word is 'INDENT'
      newTextArea.innerHTML += '&nbsp;&nbsp;'
      continue

    token = lex word

    if token is 'keyword'     then insertToken(word, 'keyword-color-picker')
    if token is 'literal'     then insertToken(word, 'literal-color-picker')
    if token is 'conjunction' then insertToken(word, 'conjunction-color-picker')
    if token is 'other'       then insertOther(word)

registerKeyword = ->
  newKeyword = document.getElementById('add-keyword').value

  unless newKeyword then alert "The textbox is empty"; return

  if newKeyword in keywordsList
    alert "This keyword is already registered: #{newKeyword}"
    return
  keywordsList.push newKeyword
  keywordsListElement.innerHTML += "<li class='keyword'>#{newKeyword}</li>"

  # clear the input field
  document.getElementById('add-keyword').value = ""

registerConjunction = ->
  newConjunction = document.getElementById('add-conjunction').value

  unless newConjunction then alert "The textbox is empty"; return

  if newConjunction in conjunctionsList
    alert "This conjunction is already registered: #{newConjunction}"
    return
  conjunctionsList.push newConjunction
  conjunctionsListElement.innerHTML += "<li class='conjunction'>#{newConjunction}</li>"

  # clear the input field
  document.getElementById('add-conjunction').value = ""

removeKeyword = ->
  if keywordToRemove == null then return

  unless keywordToRemove.value in keywordsList
    alert "The keyword #{keywordToRemove.value} is not registered."
    return

  for keywordIterator in keywordsList
    if keywordIterator is keywordToRemove.value then keywordsList.splice keywordsList.indexOf(keywordIterator), 1

  keywords = Array.from keywordsListElement.getElementsByTagName 'li'
  for keywordIterator in keywords
    if keywordIterator.innerHTML is keywordToRemove.value then keywordsListElement.removeChild keywordIterator

  # clear the input field
  keywordToRemove.value = ""

removeConjunction = ->
  if conjunctionToRemove.value == null or conjunctionToRemove.value is '' then return

  unless conjunctionToRemove.value in conjunctionsList
    alert "The conjunction #{conjunctionToRemove.value} is not registered."
    return

  for conjunctionIterator in conjunctionsList
    if conjunctionIterator is conjunctionToRemove.value
      conjunctionsList.splice conjunctionsList.indexOf(conjunctionIterator), 1

  conjunctions = Array.from conjunctionsListElement.getElementsByTagName 'li'
  for conjunctionIterator in conjunctions
    if conjunctionIterator.innerHTML is conjunctionToRemove.value
      conjunctionsListElement.removeChild conjunctionIterator

  # clear input field
  conjunctionToRemove.value = ""

saveData = ->
  data = {
    keywords: keywordsList
    conjunctions: conjunctionsList
  }
  localStorage.setItem 'data', JSON.stringify data

loadData = ->
  data = JSON.parse localStorage.getItem 'data'
  keywordsList = data.keywords
  conjunctionsList = data.conjunctions

  for keyword in keywordsList
    keywordsListElement.innerHTML += "<li>#{keyword}</li>"

  for conjunction in conjunctionsList
    conjunctionsListElement.innerHTML += "<li>#{conjunction}</li>"

toggleDarkMode = ->
  if darkMode is off
    newTextArea.style.backgroundColor = "#191a1c"
    darkMode = on
  else
    newTextArea.style.backgroundColor = "white"
    darkMode = off

toggleKeywordList = ->
  if keywordsListElement.style.display is 'none'
    keywordsListElement.style.display = 'block'
    hideKeywordListButton.innerHTML = 'Hide Keyword List'
  else
    keywordsListElement.style.display = 'none'
    hideKeywordListButton.innerHTML = 'Show Keyword List'

toggleConjunctionList = ->
  if conjunctionsListElement.style.display is 'none'
    conjunctionsListElement.style.display = 'block'
    hideConjunctionListButton.innerHTML = 'Hide Conjunction List'
  else
    conjunctionsListElement.style.display = 'none'
    hideConjunctionListButton.innerHTML = 'Show Conjunction List'

el = (id) -> document.getElementById id

el('submit-main-input').addEventListener                'click', highlightCode
el('submit-new-keyword-button').addEventListener        'click', registerKeyword
el('submit-new-conjunction-button').addEventListener    'click', registerConjunction
el('submit-remove-keyword-button').addEventListener     'click', removeKeyword
el('submit-remove-conjunction-button').addEventListener 'click', removeConjunction
el('save-registry').addEventListener                    'click', saveData
el('load-registry').addEventListener                    'click', loadData
el('toggle-dark-mode').addEventListener                 'click', toggleDarkMode
hideKeywordListButton.addEventListener                'click', toggleKeywordList
hideConjunctionListButton.addEventListener            'click', toggleConjunctionList

el('clear-highlighted-text').addEventListener 'click', -> newTextArea.innerHTML = ''

document.getElementById('scaffold-keywords').addEventListener 'click', () ->
  ["if", "else", "for", "while"].forEach (keyword) ->
    if keyword not in keywordsList
      keywordsList.push keyword
      keywordsListElement.innerHTML += "<li>#{keyword}</li>"

hidden = false
document.getElementById('hide-all-forms').addEventListener 'click', () ->
  if hidden
    document.getElementById('forms').style.display = 'block'
  else
    document.getElementById('forms').style.display = 'none'
  hidden = !hidden

