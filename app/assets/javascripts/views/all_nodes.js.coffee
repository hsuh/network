define allNodes = () ->
  allNodes    = {}
  node = null; link = null; data = null
  color    = d3.scale.category20()
  dispatch = d3.dispatch('nodeMouseOut','nodeHover')

  allNodes.getLink = () ->
    return link
  allNodes.getNode = () ->
    return node

  allNodes.attachData = (nodes_group, links_group, data) ->
    node = nodes_group.selectAll('circle').data(data.nodes)
    node.enter().append('circle')
      .attr('class', 'node')
      .attr('r', 5)
      .attr('cx', (d) -> return d.x)
      .attr('cy', (d) -> return d.y)
      .style('fill', (d) -> return color(d.group))
      .on("mouseover", dispatch.nodeHover)
      .on("mouseout", dispatch.nodeMouseOut)

    link = links_group.selectAll('line').data(data.links)
    link.enter().append('line')
      .attr('class', 'link')
      .attr("x1", (d) -> return d.source.x)
      .attr("y1", (d) -> return d.source.y)
      .attr("x2", (d) -> return d.target.x)
      .attr("y2", (d) -> return d.target.y)
      .style("stroke-width", (d) -> return d.size || 1)

  d3.rebind(allNodes, dispatch, 'on')
  return allNodes: allNodes
