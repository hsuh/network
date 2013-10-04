define ['views/all_nodes', 'views/all_clusters'], viewManager = (nodes, ac) ->
  elems  = {}
  width  = 960; height=400; forceWidth=700; forceHeight=350
  charge = 0; linkDist=0; gravity=0
  svg = null; legend=null; node=null; link=null
  nodes_group = null; links_group=null
  fill     = d3.scale.category10()
  color    = d3.scale.category20()
  dispatch = d3.dispatch('nodeMouseOut','nodeHover')
  allNodes = nodes.allNodes
  clusters = ac.allClusters

  elems.appendElems = () ->
    svg         = d3.select("#viz").append("svg")
                  .attr("width", width)
                  .attr("height", height)
    legends     = svg.append("g").attr("class", "legends")
    links_group = svg.append("g").attr("class", "links")
    nodes_group = svg.append("g").attr("class", "nodes")
    svg.attr('opacity', 1e-6).transition().duration(1000).attr('opacity', 1)

  elems.attachDataToElems = (data, scope) ->
    if scope == 'all'
      links_group = d3.select('g.links')
      nodes_group = d3.select('g.nodes')
      allNodes.attachData(nodes_group, links_group, data)
    if scope == 'webcasts'
      links_group = d3.select('g.links')
      nodes_group = d3.select('g.nodes')
      clusters.attachData(nodes_group, links_group, data)

  return viewManager: elems
