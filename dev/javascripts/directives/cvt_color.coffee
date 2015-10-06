angular.module('SampleApp').directive 'cvtColor', (Endpoints, Element)->
  templateUrl: 'assets/templates/cvt_color.html'
  replace: true
  link: (scope, elem, attrs)->
    element = Element.get()
    endpoints = Endpoints.get()

    maxConnectionsCallback = (info) ->
      alert 'Cannot drop connection ' + info.connection.id + ' : maxConnections has been reached on Endpoint ' + info.endpoint.id
      return

    el = element.addEndpoint(elem, { anchor: ['LeftMiddle'] }, endpoints.mat)
    element.addEndpoint(elem, { anchor: ['RightMiddle'] }, endpoints.integer)
    element.addEndpoint(elem, { anchor: ['RightMiddle'] }, endpoints.type)


    el.bind 'maxConnections', maxConnectionsCallback

    element.draggable elem
