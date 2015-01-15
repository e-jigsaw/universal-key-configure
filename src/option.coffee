React = require 'react'
{div, h1, textarea, button, p} = React.DOM
jss = require 'jss'

Option = React.createClass
  getInitialState: ->
    config: 'waiwai'
    isSaved: false

  _onClick: ->
    @setState
      config: @refs.textarea.getDOMNode().value
    , =>
      @setState
        isSaved: true

  render: ->
    div {className: 'option'}, [
      h1 {}, 'Universal key configure'
      p {}, [
        textarea {ref: 'textarea', defaultValue: @state.config}
      ]
      p {}, [
        button {onClick: @_onClick}, 'Save'
      ]
      if @state.isSaved then p {}, 'saved'
    ]

React.render React.createElement(Option), document.body

jss.createStyleSheet
  textarea:
    width: '400px'
    height: '300px'
  button:
    width: '400px'
.attach()
