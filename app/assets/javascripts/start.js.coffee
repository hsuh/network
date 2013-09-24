define ['process_data', 'view_manager', 'layout_manager', 'behaviour_manager'], start = (pd, vm, lm,bm) ->
  return start: () ->
    dataManager   = pd.dataManager
    viewManager   = vm.viewManager
    behaviourManager = bm.behaviourManager
    console.log(behaviourManager)

    viewManager.appendElems()
    dataManager.loadData()

    dataManager.on('dataReady', () ->
      dataManager.debugData()
      data = dataManager.getData()
      viewManager.attachDataToElems(data)
      layoutManager = lm.layoutManager
      layoutManager.initiate(data)
      behaviourManager.listenForEvents(viewManager)
    )


