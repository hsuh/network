define ['views/all_nodes'], layoutManager = (vm) ->
  layout  = {}
  charge  = 0; linkDist=0; gravity=0
  forceWidth=960; forceHeight=400
  viewManager = vm.allNodes

  tick = () ->
    link = viewManager.getLink()
    node = viewManager.getNode()
    link.attr("x1", (d) -> d.source.x)
      .attr("y1", (d) -> d.source.y)
      .attr("x2", (d) -> return d.target.x)
      .attr("y2", (d) -> return d.target.y)

    node.attr("cx", (d) -> return d.x )
      .attr("cy", (d) -> return d.y )

  layout.initiate = (data, type) ->
    force = d3.layout.force()
    if type == 'all'
      force.charge(-400)
        .linkDistance(20)
        .gravity(1.3)
        .nodes(data.nodes)
        .links(data.links)
        .size([forceWidth, forceHeight])
        .on("tick", tick)
    if type == 'cluster'
      force.charge(-200)
        .linkDistance(300)
        .gravity(1.2)
        .nodes(data.nodes)
        .links(data.links)
        .size([forceWidth, forceHeight])
        .on("tick", tick)
    force.start()

  layout.restart = (data, type) ->
    if force
      force.stop
    layout.initiate(data, type)

  return layoutManager: layout
