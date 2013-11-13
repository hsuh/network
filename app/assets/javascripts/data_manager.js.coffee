define ['data/get_clusters'], processData = (clusterData) ->
  data     = null
  exports  = {}
  dispatch = d3.dispatch('dataReady')
  clusters = clusterData.clusters

  getNodesForLinkSourceAndTarget = (data, link_obj) ->
    if data == null then return
    $.each data.nodes, (k,v) ->
      if (v.user_id == link_obj.source)
        link_obj.source = v
      if (v.user_id == link_obj.target)
        link_obj.target = v

  prepareData = () ->
    if data == null then return
    $.each data.links, (k,link_obj) ->
      getNodesForLinkSourceAndTarget(data, link_obj)

    $.each data.nodes, (k, node_obj) ->
      node_obj.leaf_link_count = 0
      $.each data.links, (k, link) ->
        if link.source == node_obj || link.target == node_obj
          node_obj.leaf_link_count += 1
    return data

  trimNodes = () ->
    data_len = data.nodes.length - 1
    $.each data.nodes, (k, node_obj) ->
      if data.nodes[data_len - k].leaf_link_count == 0
        data.nodes.splice(data_len-k,1)

  cleanData = (_data) ->
    data = _data
    data = prepareData()
    trimNodes()
    dispatch.dataReady()

  exports.getNodesOfGroup = () ->

  exports.debugData = () ->
    console.log('clean data', data)

  exports.getClusters = () ->
    clusterData = clusters.getData(data, "all")
    return clusterData

  exports.getData = () ->
    return data

  exports.getBlueData = () ->
    blueData = clusters.getGroupedData(data)
    return blueData

  exports.loadData = () ->
    d3.json('data/cpd_users.json', cleanData)
    #d3.json('http://localhost:8080/feusd-insight/clusters/webcasts.json', cleanData)

  d3.rebind(exports, dispatch, 'on')
  return {
    dataManager: exports
  }
