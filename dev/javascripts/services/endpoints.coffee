angular.module('SampleApp').service 'Endpoints', () ->
  endpoints = {}

  exampleDropOptions =
    tolerance: 'touch'
    hoverClass: 'dropHover'
    activeClass: 'dragActive'

  exampleColor = '#00f'
  color2 = '#316b31'
  example3Color = 'rgba(229,219,61,0.5)'

  integer =
    endpoint: 'Rectangle'
    paintStyle:
      width: 25
      height: 21
      fillStyle: exampleColor
    isSource: true
    reattach: true
    scope: 'blue'
    connectorStyle:
      gradient: stops: [
        [
          0
          exampleColor
        ]
        [
          0.5
          '#09098e'
        ]
        [
          1
          exampleColor
        ]
      ]
      lineWidth: 5
      strokeStyle: exampleColor
      dashstyle: '2 2'
    isTarget: true
    beforeDrop: (params) ->
      confirm 'Connect ' + params.sourceId + ' to ' + params.targetId + '?'
    dropOptions: exampleDropOptions

  mat =
    endpoint: [
      'Dot'
      { radius: 11 }
    ]
    paintStyle: fillStyle: color2
    isSource: true
    scope: 'green'
    connectorStyle:
      strokeStyle: color2
      lineWidth: 6
    connector: [
      'Bezier'
      { curviness: 63 }
    ]
    maxConnections: 3
    isTarget: true
    dropOptions: exampleDropOptions

  type =
    endpoint: [
      'Dot'
      { radius: 17 }
    ]
    anchor: 'BottomLeft'
    paintStyle:
      fillStyle: example3Color
      opacity: 0.5
    isSource: true
    scope: 'yellow'
    connectorStyle:
      strokeStyle: example3Color
      lineWidth: 4
    connector: 'Straight'
    isTarget: true
    dropOptions: exampleDropOptions
    beforeDetach: (conn) ->
      confirm 'Detach connection?'
    onMaxConnections: (info) ->
      alert 'Cannot drop connection ' + info.connection.id + ' : maxConnections has been reached on Endpoint ' + info.endpoint.id
      return


  endpoints.integer = integer
  endpoints.mat = mat
  endpoints.type = type

  getEndpoints = ()->
    endpoints

  {
    get: getEndpoints
  }
