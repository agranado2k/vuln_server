class VulnerabilitiesController < ApplicationController
  class RequiredParameters < RuntimeError
    def initialize(params)
      @params = params || []
    end
    attr_reader :params
  end

  rescue_from RequiredParameters, with: :required_parameters

  def index
    validate_request
    render json: [], status: :ok
  end

  private

    def validate_request
      missed_params = []
      missed_params.push :group_id unless params[:group_id].present?
      missed_params.push :artifact_id unless params[:artifact_id].present?
      missed_params.push :version unless params[:version].present?
      raise RequiredParameters.new missed_params unless missed_params.empty?
    end

    def required_parameters(e)
      render json: { validation_errors: e.params.map { |p| { p => 'required' } } }, status: :bad_request
    end
end
