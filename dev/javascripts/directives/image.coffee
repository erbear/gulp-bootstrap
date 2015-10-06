angular.module('SampleApp').directive 'image', (Endpoints, Element)->
  templateUrl: 'assets/templates/image.html'
  replace: true
  link: (scope, elem, attrs)->
    element = Element.get()
    endpoints = Endpoints.get()

    maxConnectionsCallback = (info) ->
      alert 'Cannot drop connection ' + info.connection.id + ' : maxConnections has been reached on Endpoint ' + info.endpoint.id
      return

    el = element.addEndpoint(elem, { anchor: [1, 0.5] }, endpoints.mat)


    el.bind 'maxConnections', maxConnectionsCallback

    element.draggable elem
