define allClusters = () ->
  allClusters    = {}
  node = null; link = null
  colour    = d3.scale.category20()
  dispatch = d3.dispatch('clusterMouseOut','clusterHover')
  average_gSize = null

  allClusters.getLink = () ->
    return link
  allClusters.getNode = () ->
    return node

  calculateNodeSize = (d) ->
    if average_gSize > 100
      return (if d.size then parseInt(d.size/10) else  4)
    else
      console.log('d.size', d.size)
      return (if d.size then d.size + 3 else 4)

  getColour = (d) ->
    return colour(d.group)

  getNodeID = (d) ->
    return (d.group)

  getLinkID = (l) ->
    u = getNodeID(l.source)
    v = getNodeID(l.target)
    return (if (u<v) then (u + "|" + v) else (v + "|" + u))

  allClusters.attachData = (nodes_group, links_group, data) ->
    average_gSize = data.averageGroupSize
    node = nodes_group.selectAll('circle').data(data.nodes, getNodeID)
    node.exit().remove()
    node.enter().append('circle')
    nodes = d3.selectAll('circle')
      .classed('node group', true)
      .attr('r', calculateNodeSize)
      .attr('cx', (d) -> return d.x)
      .attr('cy', (d) -> return d.y)
      .style('fill', getColour)
      .on("mouseover", dispatch.clusterHover)
      .on("mouseout", dispatch.clusterMouseOut)

    link = d3.select('g.links').selectAll('line').data(data.links)
    link.exit().remove()
    link = d3.select('g.links').selectAll('line').data(data.links, getLinkID)
    #console.log('data links', getLinkID d for d in data.links)
    link.enter().append('line')
    links = d3.selectAll('line')
    links
      .classed('link group', true)
      .attr("x1", (d) -> return d.source.x)
      .attr("y1", (d) -> return d.source.y)
      .attr("x2", (d) -> return d.target.x)
      .attr("y2", (d) -> return d.target.y)
      .style("stroke-width", (d) -> return d.size || 1)

  d3.rebind(allClusters, dispatch, 'on')
  return allClusters: allClusters
