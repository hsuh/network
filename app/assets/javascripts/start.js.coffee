define ['data_manager', 'view_manager', 'layout_manager', 'behaviour_manager', 'layouts/fd_for_clusters', 'views/all_nodes'], start = (pd, vm, lm,bm, fdc, all_nodes) ->
  return start: () ->
    dataManager      = pd.dataManager
    viewManager      = vm.viewManager
    behaviourManager = bm.behaviourManager
    allNodes         = all_nodes.allNodes
    data = null; clusterData = null; blueData = null
    console.log(behaviourManager)

    viewManager.appendElems()

    dataManager.loadData()
    dataManager.on('dataReady', () ->
      dataManager.debugData()
      data        = dataManager.getData()
      clusterData = dataManager.getClusters()
      blueData    = dataManager.getBlueData()
      viewManager.attachDataToElems(data, 'all')
      layoutManager = lm.layoutManager
      layoutManager.initiate(data, 'all')
      behaviourManager.listenForEvents(allNodes)

      $('.brand').on('click', (e) ->
        e.preventDefault()
      )

      $('#all_nodes').on('click', (e) ->
        e.preventDefault()
        data = dataManager.getData()
        viewManager.attachDataToElems(data, 'all')
        layoutManager.initiate(data, 'all')
        $('#webcast_nodes').removeClass("active")
        $('#webcast_inside').removeClass("active")
        $('#all_nodes').addClass("active")
      )

      $('#webcast_nodes').on('click', (e) ->
        e.preventDefault()
        viewManager.attachDataToElems(clusterData, 'webcasts')
        layoutManager.initiate(clusterData, 'cluster')
        $('#all_nodes').removeClass("active")
        $('#webcast_inside').removeClass("active")
        $('#webcast_nodes').addClass("active")
      )

      $('#webcast_inside').on('click', (e) ->
        e.preventDefault()
        viewManager.attachDataToElems(blueData, 'all')
        layoutManager.initiate(blueData, 'all')
        $('#all_nodes').removeClass("active")
        $('#webcast_nodes').removeClass("active")
        $('#webcast_inside').addClass("active")
      )
    )
