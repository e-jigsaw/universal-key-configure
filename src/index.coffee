COMMANDS = ['tab', 'test', 'test2']
fuse = new Fuse COMMANDS

new Vue
  el: '#command'
  data:
    word: ''
    results: []
  methods:
    search: ->
      res = fuse.search @.$data.word
      len = if @.$data.results.length > res.length then @.$data.results.length else res.length
      [0..len].forEach (i)=>
        if res[i]?
          @.$data.results.$set i, COMMANDS[res[i]]
        else
          if @.$data.results[i]? then @.$data.results.$remove i
