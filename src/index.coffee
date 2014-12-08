COMMANDS = [
  {
    full: 'tab'
    alias: 't'
    description: 'Move current tab'
  }
]
fuse = new Fuse COMMANDS,
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
        res = fuse.search @.$data.word
        len = if @.$data.results.length > res.length then @.$data.results.length else res.length
        [0..len].forEach (i)=>
          if res[i]?
            @.$data.results.$set i, res[i]
          else
            if @.$data.results[i]? then @.$data.results.$remove i
