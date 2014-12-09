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
    compselect: null
  methods:
    keycheck: (event)->
      switch event.keyCode
        when 9 # tab
          event.preventDefault()
          @complete event
        when 13 # Enter
          @run()
    complete: (event)->
      target = @.$data.word.split ' '
      if _.last(target).length is 0 then target = _.initial(target)
      @.$data.compselect =
        if @.$data.compselect is null
          0
        else if event.shiftKey
          n = @.$data.compselect - 1
          if n < 0 then @.$data.results.length - 1 else n
        else
          n = @.$data.compselect + 1
          if n > (@.$data.results.length - 1) then 0 else n
      target[target.length-1] = @.$data.results[@.$data.compselect].comp
      @.$data.word = target.join(' ') + ' '
    search: (event)->
      target = @.$data.word.split ' '
      if event.keyCode isnt 9
        if target.length is 1
          res = commandsFuse.search @.$data.word
          @resultApply @cmdgen(res)
        else if target.length is 2
          if target[0] is COMMANDS[0].full or target[0] is COMMANDS[0].alias then @tabSelector target[1]
    cmdgen: (res)-> _.map res, (row)->
      r =
        display: "#{row.full} - #{row.description}"
        comp: row.full
        original: row
    tabgen: (res)-> _.map res, (row)->
      r =
        display: "#{row.key}: #{row.title} #{row.url}"
        comp: row.key
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
    run: ->
      console.log 'Run'
