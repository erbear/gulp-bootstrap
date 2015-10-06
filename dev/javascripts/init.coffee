angular.module('SampleApp', ['ui.router'])
  .run (Element)->
    instance = jsPlumb.getInstance(
      Container: 'canvas')

    Element.set(instance)
    Element.initialize()
