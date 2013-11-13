define ['views/all_clusters'], behaviourManager = (ac) ->
  exports     = {}
  clusterData = ac.allClusters

  nodeChangeSize = (d, opt) ->
    if opt == 'zoom' then return 5 * 2
    if opt == 'shrink' then return 5

  exports.listenForEvents = (viewManager) ->
    node = viewManager.getNode
    link = viewManager.getLink
    viewManager.on('nodeHover', (d,i) ->
      s = d3.select(this)
      s.transition().attr('r', nodeChangeSize(d, 'zoom'))
      console.log('data on hover', d)
    )
    viewManager.on('nodeMouseOut', (d,i) ->
      s = d3.select(this)
      s.transition().attr('r', nodeChangeSize(d, 'shrink'))
    )

  return behaviourManager: exports
