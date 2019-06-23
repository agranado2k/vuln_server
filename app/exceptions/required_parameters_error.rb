# frozen_string_literal: true

class RequiredParametersError < RuntimeError
  def initialize(params)
    super
    @params = params || []
  end
  attr_reader :params
end
