angular.module('SampleApp').service 'Element', () ->
  instance = null

  setInstance = (inst)->
    instance = inst

  getInstance = ->
    instance

  updateConnections = (conn, remove) ->
    console.log conn
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

  initialize = ->
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


  {
    set: setInstance
    get: getInstance
    initialize: initialize
  }
