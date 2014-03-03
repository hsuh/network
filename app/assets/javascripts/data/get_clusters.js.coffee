define getClusters = () ->
  clusters = {}
  gm     = {} #group map
  nm     = {} #node map
  lm     = {} #link map
  gn     = {} #previous group nodes
  gc     = {} #previous group centroids
  nodes  = [] #output nodes
  links  = [] #output links
  total_size = 0
  data   = null
  avg    = null

  getGroup = (n) ->
    if n != undefined
      return n.group

  averageGroupSize = (data) ->
    if data.clusters
      return parseInt(data.nodes.length / data.clusters.length)
    else
      return parseInt(data.nodes.length / 6)

  clusters.getGroupedData = (data) ->
    blueNodes = []
    blueLinks = []
    data = data
    for k in [0..data.nodes.length-1]
      n = data.nodes[k]
      i = getGroup(n)
      if i == 0
        blueNodes.push(n)

    for k in [0..data.links.length-1]
      l = data.links[k]
      u = getGroup(l.source)
      v = getGroup(l.target)

      if u == 0 and v == 0
        blueLinks.push(l)

    console.log('group 0 nodes', nodes)
    return {"clusters": data.clusters, "nodes": blueNodes, "links": blueLinks}

  clusters.getData = (data) ->
    data = data
    avg  = averageGroupSize(data)
    #determine nodes
    for k in [0..data.nodes.length-1]
      n = data.nodes[k]
      i = getGroup(n) #getGroup
      l = gm[i] || (gm[i]=gn[i]) || (gm[i]={"group":i, "size":0, "nodes":[]})

      if(l.size == 0)
        nm[i] = nodes.length
        nodes.push(l)
        if gc[i]
          l.x = gc[i].x / gc[i].count
          l.y = gc[i].y / gc[i].count

      l.nodes.push(n)
      l.size += 1
      n.group_data = l

    for i of gm
      gm[i].link_count = 0

    #determine links
    for k in [0..data.links.length-1]
      e = data.links[k]
      u = getGroup(e.source)
      v = getGroup(e.target)

      if u != v
        gm[u].link_count++
        gm[v].link_count++

      u = nm[u]
      v = nm[v]
      i = if (u < v) then (u + "|" + v) else (v + "|" + u)
      l = lm[i] || (lm[i] = {"source" : u, "target" : v, "size" : 0})
      l.size += 1

    for i of lm
      links.push(lm[i])
      total_size = total_size + i.size

    avg_Link_Size = total_size / links.length

    return {"clusters": data.clusters, "nodes": nodes, "links": links, "averageGroupSize": avg, "averageLinkGroupSize": avg_Link_Size}

  return clusters: clusters
