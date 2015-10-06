angular.module('SampleApp').controller 'HomeCtrl', ($scope, Endpoints) ->
  $scope.home = "home"
  endpoints = Endpoints.get()
  listDiv = document.getElementById('list')

  showConnectionInfo = (s) ->
    listDiv.innerHTML = s
    listDiv.style.display = 'block'
    return

  hideConnectionInfo = ->
    listDiv.style.display = 'none'
    return

  connections = []

  updateConnections = (conn, remove) ->
    if !remove
      connections.push conn
    else
      idx = -1
      i = 0
      while i < connections.length
        if connections[i] == conn
          idx = i
          break
        i++
      if idx != -1
        connections.splice idx, 1
    if connections.length > 0
      s = '<span><strong>Connections</strong></span><br/><br/><table><tr><th>Scope</th><th>Source</th><th>Target</th></tr>'
      j = 0
      while j < connections.length
        s = s + '<tr><td>' + connections[j].scope + '</td>' + '<td>' + connections[j].sourceId + '</td><td>' + connections[j].targetId + '</td></tr>'
        j++
      showConnectionInfo s
    else
      hideConnectionInfo()
    return

  jsPlumb.ready ->
    instance = jsPlumb.getInstance(
      DragOptions:
        cursor: 'pointer'
        zIndex: 2000
      PaintStyle: strokeStyle: '#666'
      EndpointHoverStyle: fillStyle: 'orange'
      HoverPaintStyle: strokeStyle: 'orange'
      EndpointStyle:
        width: 20
        height: 16
        strokeStyle: '#666'
      Endpoint: 'Rectangle'
      Anchors: [
        'TopCenter'
        'TopCenter'
      ]
      Container: 'canvas')
    # suspend drawing and initialise.
    instance.batch ->
      # bind to connection/connectionDetached events, and update the list of connections on screen.
      instance.bind 'connection', (info, originalEvent) ->
        updateConnections info.connection
        return
      instance.bind 'connectionDetached', (info, originalEvent) ->
        updateConnections info.connection, true
        return
      instance.bind 'connectionMoved', (info, originalEvent) ->
        #  only remove here, because a 'connection' event is also fired.
        # in a future release of jsplumb this extra connection event will not
        # be fired.
        updateConnections info.connection, true
        return
      instance.bind 'click', (component, originalEvent) ->
        alert 'click!'
        return
      # setup some empty endpoints.  again note the use of the three-arg method to reuse all the parameters except the location
      # of the anchor (purely because we want to move the anchor around here; you could set it one time and forget about it though.)
      e1 = instance.addEndpoint('dragDropWindow1', { anchor: [
        0.5
        1
        0
        1
      ] }, endpoints.mat)
      # setup some DynamicAnchors for use with the blue endpoints
      # and a function to set as the maxConnections callback.
      anchors = [
        [
          1
          0.2
          1
          0
        ]
        [
          0.8
          1
          0
          1
        ]
        [
          0
          0.8
          -1
          0
        ]
        [
          0.2
          0
          0
          -1
        ]
      ]

      maxConnectionsCallback = (info) ->
        `var e1`
        alert 'Cannot drop connection ' + info.connection.id + ' : maxConnections has been reached on Endpoint ' + info.endpoint.id
        return

      e1 = instance.addEndpoint('dragDropWindow1', { anchor: anchors }, endpoints.integer)
      # you can bind for a maxConnections callback using a standard bind call, but you can also supply 'onMaxConnections' in an Endpoint definition - see endpoints.type above.
      e1.bind 'maxConnections', maxConnectionsCallback
      e2 = instance.addEndpoint('dragDropWindow2', { anchor: [
        0.5
        1
        0
        1
      ] }, endpoints.integer)
      # again we bind manually. it's starting to get tedious.  but now that i've done one of the blue endpoints this way, i have to do them all...
      e2.bind 'maxConnections', maxConnectionsCallback
      instance.addEndpoint 'dragDropWindow2', { anchor: 'RightMiddle' }, endpoints.mat
      e3 = instance.addEndpoint('dragDropWindow3', { anchor: [
        0.25
        0
        0
        -1
      ] }, endpoints.integer)
      e3.bind 'maxConnections', maxConnectionsCallback
      instance.addEndpoint 'dragDropWindow3', { anchor: [
        0.75
        0
        0
        -1
      ] }, endpoints.mat
      e4 = instance.addEndpoint('dragDropWindow4', { anchor: [
        1
        0.5
        1
        0
      ] }, endpoints.integer)
      e4.bind 'maxConnections', maxConnectionsCallback
      instance.addEndpoint 'dragDropWindow4', { anchor: [
        0.25
        0
        0
        -1
      ] }, endpoints.mat
      # make .window divs draggable
      instance.draggable jsPlumb.getSelector('.drag-drop-demo .window')
      # add endpoint of type 3 using a selector.
      instance.addEndpoint jsPlumb.getSelector('.drag-drop-demo .window'), endpoints.type
      hideLinks = jsPlumb.getSelector('.drag-drop-demo .hide')
      instance.on hideLinks, 'click', (e) ->
        instance.toggleVisible @getAttribute('rel')
        jsPlumbUtil.consume e
        return
      dragLinks = jsPlumb.getSelector('.drag-drop-demo .drag')
      instance.on dragLinks, 'click', (e) ->
        s = instance.toggleDraggable(@getAttribute('rel'))
        @innerHTML = if s then 'disable dragging' else 'enable dragging'
        jsPlumbUtil.consume e
        return
      detachLinks = jsPlumb.getSelector('.drag-drop-demo .detach')
      instance.on detachLinks, 'click', (e) ->
        instance.detachAllConnections @getAttribute('rel')
        jsPlumbUtil.consume e
        return
      instance.on document.getElementById('clear'), 'click', (e) ->
        instance.detachEveryConnection()
        showConnectionInfo ''
        jsPlumbUtil.consume e
        return
      return
    jsPlumb.fire 'jsPlumbDemoLoaded', instance
    return
  return

# ---
# generated by js2coffee 2.1.0
