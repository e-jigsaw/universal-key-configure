React = require 'react'
{div, h1, textarea, button, p} = React.DOM
jss = require 'jss'

Option = React.createClass
  _onClick: ->
    console.log 'click'

  render: ->
    div {className: 'option'}, [
      h1 {}, 'Universal key configure'
      p {}, [
        textarea {}
      ]
      p {}, [
        button {onClick: @_onClick}, 'Save'
      ]
    ]

React.render React.createElement(Option), document.body

jss.createStyleSheet
  textarea:
    width: '400px'
    height: '300px'
  button:
    width: '400px'
.attach()
