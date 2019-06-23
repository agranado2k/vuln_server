# frozen_string_literal: true

class RequiredParametersError < RuntimeError
  def initialize(params)
    @params = params || []
  end
  attr_reader :params
end
