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
        @resultApply @cmdgen(res)
      else if target.length is 2
        if target[0] is COMMANDS[0].full or target[0] is COMMANDS[0].alias then @tabSelector target[1]
    cmdgen: (res)-> _.map res, (row)->
      r =
        display: "#{row.full} - #{row.description}"
        original: row
    tabgen: (res)-> _.map res, (row)->
      r =
        display: "#{row.key}: #{row.title} #{row.url}"
        original: row
    keygen: (num)->
      num = num.toString(16).split ''
      shortcuts = 'asdfqwerzxcv1234'.split ''
      hex       = '0123456789abcdef'.split ''
      zip       = _.zipObject hex, shortcuts
      _.reduce _.rest(num), (sum, c)->
        "#{sum}#{zip[c]}"
      , zip[_.first(num)]
    resultApply: (res)->
      len = if @.$data.results.length > res.length then @.$data.results.length else res.length
      [0..len].forEach (i)=>
        if res[i]?
          @.$data.results.$set i, res[i]
        else
          if @.$data.results[i]? then @.$data.results.$remove i
    tabSelector: (word)-> chrome.tabs.query {}, (tabs)=>
      tabs = _.map tabs, (tab, i)=>
        tab.key = @keygen i
        tab
      tabFuse = new Fuse tabs,
        keys: ['title', 'url', 'key']
      res = tabFuse.search word
      @resultApply @tabgen(res)
