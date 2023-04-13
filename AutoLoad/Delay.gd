extends Node


## Wait for some Seconds
func Seconds(sec: float) -> Signal:
	return get_tree().create_timer(sec).timeout

## Wait for the next frame
func NextFrame() -> Signal:
	return get_tree().process_frame


## Wait for the next physics frame
func NextPhysicsFrame() -> Signal:
	return get_tree().physics_frame


## Wait for all signals to trigger
## ToDo: Would be nice to have a timeout abort option
func AllSignals(signals: Array[Signal], combinedSignalName: String) -> Signal:
	var signalCount: int = signals.size()
	add_user_signal(combinedSignalName)
	var combined: Signal = Signal(self, combinedSignalName)
	var combinedState = { doneCount = 0 } # By wrapping in an object, we can pass by ref to share
	var lam = func(state, i):
		state.doneCount += 1
		print("AllSignals " + combinedSignalName + " #" + str(i) + " done:" + str(state.doneCount) + " of " + str(signalCount))
		if (state.doneCount == signalCount):
			combined.emit()
	for i in signalCount:
		signals[i].connect(lam.bind(combinedState, i), CONNECT_ONE_SHOT + CONNECT_DEFERRED)
	return combined
