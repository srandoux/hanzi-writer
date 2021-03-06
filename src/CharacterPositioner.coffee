Drawable = require('./Drawable.coffee')

class CharacterPositioner extends Drawable

	constructor: (@character, @options = {}) ->

	getBounds: -> @character.getBounds()

	convertExternalPoints: (points) -> (@convertExternalPoint(point) for point in points)
	convertExternalPoint: (point) ->
		x: (point.x - @xOffset) / @scale
		y: (point.y - @yOffset) / @scale

	getNestedCanvas: ->
		@calculateScaleAndOffset()
		@canvas
			.group()
			.move(@xOffset, @yOffset)
			.transform(scaleX: @scale, scaleY: @scale)

	calculateScaleAndOffset: ->
		bounds = @getBounds()
		preScaledWidth = bounds[1].x - bounds[0].x
		preScaledHeight = bounds[1].y - bounds[0].y
		effectiveWidth = @options.width - 2 * @options.padding
		effectiveHeight = @options.height - 2 * @options.padding
		scaleX = effectiveWidth / preScaledWidth
		scaleY = effectiveHeight / preScaledHeight
		
		@scale = Math.min(scaleX, scaleY)

		xCenteringBuffer = @options.padding + (effectiveWidth - @scale * preScaledWidth) / 2
		yCenteringBuffer = @options.padding + (effectiveHeight - @scale * preScaledHeight) / 2
		@xOffset = -1 * bounds[0].x * @scale + xCenteringBuffer
		@yOffset = -1 * bounds[0].y * @scale + yCenteringBuffer

	draw: -> @character.draw()
	animate: (svg, onComplete = ->) -> @character.animate(onComplete)
	setCanvas: (canvas) ->
		super
		@character.setCanvas(@getNestedCanvas())

module.exports = CharacterPositioner