define ['views/all_clusters'], behaviourManager = (ac) ->
  exports     = {}
  clusterData = ac.allClusters

  nodeChangeSize = (d, opt) ->
    if opt == 'zoom' then return 5 * 2
    if opt == 'shrink' then return 5

  hideLinks = (i) ->
    lines = d3.select('svg').selectAll('line')
    lines.filter((d) -> return (d.source.index != i && d.target.index != i))
      .attr("display", "none")
    #transitions are prettier but too slow for 100s of links
    #.transition()
    #.style("opacity", opacity)

  showLinks = (i) ->
    lines = d3.select('svg').selectAll('line')
    lines.filter((d) -> return (d.source.index != i && d.target.index != i))
      .attr("display", "inline")

  exports.listenForEvents = (viewManager) ->
    node = viewManager.getNode
    link = viewManager.getLink
    viewManager.on('nodeHover', (d,i) ->
      s = d3.select(this)
      s.transition().attr('r', nodeChangeSize(d, 'zoom'))
      hideLinks(i)
      console.log('data on hover', d)
    )
    viewManager.on('nodeMouseOut', (d,i) ->
      s = d3.select(this)
      s.transition().attr('r', nodeChangeSize(d, 'shrink'))
      showLinks(i)
    )

  return behaviourManager: exports
