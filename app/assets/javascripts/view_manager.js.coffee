define view_manager = () ->
  elems  = {}
  width  = 960; height=400; forceWidth=700; forceHeight=350
  charge = 0; linkDist=0; gravity=0
  svg = null; legend=null; node=null; link=null
  nodes_group = null; links_group=null
  fill     = d3.scale.category10()
  color    = d3.scale.category20()
  dispatch = d3.dispatch('nodeMouseOut','nodeHover')

  elems.appendElems = () ->
    svg      = d3.select("#viz").append("svg")
              .attr("width", width)
              .attr("height", height)
    legends  = svg.append("g").attr("class", "legends")
    links_group = svg.append("g").attr("class", "links")
    nodes_group = svg.append("g").attr("class", "nodes")
    link = links_group.selectAll('line')
    svg.attr('opacity', 1e-6).transition().duration(1000).attr('opacity', 1)

  elems.getLink = () ->
    return link
  elems.getNode = () ->
    return node

  elems.attachDataToElems = (data) ->
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

  d3.rebind(elems, dispatch, 'on')
  return viewManager: elems
