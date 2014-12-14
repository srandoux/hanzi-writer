moduleKeywords = ['extended', 'included']

class Mixable
	@extend: (obj) ->
		for key, value of obj when key not in moduleKeywords
			@[key] = value

		obj.extended?.apply(@)
		return @

	@include: (obj) ->
		for key, value of obj when key not in moduleKeywords
			# Assign properties to the prototype
			@::[key] = value

		obj.included?.apply(@)
		return @

module.exports = Mixable