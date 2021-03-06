class Drawable

	draw: -> # implement in children
	animate: (onComplete = ->) -> # implement in children
	getBounds: -> # implement in children
	setCanvas: (@canvas) ->

	### convenience methods for children ###

	getExtremes: (numArray) ->
		max = Math.max.apply(null, numArray)
		min = Math.min.apply(null, numArray)
		mid = (max + min) / 2
		return [max, mid, min]

	getAllXs: (points) -> point.x for point in points
	getAllYs: (points) -> point.y for point in points

module.exports = Drawable