define behaviour_manager = () ->
  exports     = {}

  nodeChangeSize = (d, opt) ->
    if opt == 'zoom' then return 5 * 2
    if opt == 'shrink' then return 5

  exports.listenForEvents = (viewManager) ->
    node = viewManager.getNode
    link = viewManager.getLink
    viewManager.on('nodeHover', (d,i) ->
      s = d3.select(this)
      s.transition().attr('r', nodeChangeSize(d, 'zoom'))
    )
    viewManager.on('nodeMouseOut', (d,i) ->
      s = d3.select(this)
      s.transition().attr('r', nodeChangeSize(d, 'shrink'))
    )

  return behaviourManager: exports

