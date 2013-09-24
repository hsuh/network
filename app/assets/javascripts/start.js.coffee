define ['process_data', 'view_manager', 'layout_manager', 'behaviour_manager', 'layouts/fd_for_clusters', 'views/all_nodes'], start = (pd, vm, lm,bm, fdc, all_nodes) ->
  return start: () ->
    dataManager      = pd.dataManager
    viewManager      = vm.viewManager
    behaviourManager = bm.behaviourManager
    allNodes         = all_nodes.allNodes
    console.log(behaviourManager)

    viewManager.appendElems()
    dataManager.loadData()

    dataManager.on('dataReady', () ->
      dataManager.debugData()
      data = dataManager.getData()
      viewManager.attachDataToElems(data)
      layoutManager = lm.layoutManager
      layoutManager.initiate(data)
      behaviourManager.listenForEvents(allNodes)
    )


