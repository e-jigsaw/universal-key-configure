COMMANDS = [
  {
    full: 'tab'
    alias: 't'
    description: 'Move current tab'
  }
]
commandsFuse = new Fuse COMMANDS,
  keys: ['full', 'alias', 'description']

new Vue
  el: '#command'
  data:
    word: ''
    results: []
  methods:
    tabcheck: (event)->
      if event.keyCode is 9
        event.preventDefault()
        @complete()
    complete: ->
    search: (event)->
      target = @.$data.word.split ' '
      if target.length is 1
        res = commandsFuse.search @.$data.word
        len = if @.$data.results.length > res.length then @.$data.results.length else res.length
        [0..len].forEach (i)=>
          if res[i]?
            @.$data.results.$set i, res[i]
          else
            if @.$data.results[i]? then @.$data.results.$remove i
      else if target.length is 2
        if target[0] is COMMANDS[0].full or target[0] is COMMANDS[0].alias then @tabSelector()
    keygen: (num)->
      keyCandidate = 'asdfqwerzxcv1234'.split ''
      keylen = keyCandidate.length
      if num < keylen
        return keyCandidate[num]
      else if (n = Math.floor(num / keyCandidate.length)) < keylen
        return keyCandidate[n] + keygen(num - (n * keylen))
    tabSelector: -> chrome.tabs.query {}, (tabs)->
      tabFuse = new Fuse tabs,
        keys: ['title', 'url']
