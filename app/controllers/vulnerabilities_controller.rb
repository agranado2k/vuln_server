# frozen_string_literal: true

class VulnerabilitiesController < ApplicationController
  rescue_from ::RequiredParametersError, with: :required_parameters

  def index
    validate_request
    vuln = Vulnerability.new
    list = vuln.check(create_params)
    render json: list, status: :ok
  end

  private

    def validate_request
      mp = missed_params
      message = 'Required parameters missing'
      raise ::RequiredParametersError.new(mp), message unless mp.empty?
    end

    def missed_params
      missed_params = []
      missed_params.push :group_id if params[:group_id].blank?
      missed_params.push :artifact_id if params[:artifact_id].blank?
      missed_params.push :version if params[:version].blank?
      missed_params
    end

    def required_parameters(errors)
      render json: format_errors(errors), status: :bad_request
    end

    def format_errors(errors)
      { validation_errors: errors.params.map { |p| { p => 'required' } } }
    end

    def create_params
      {
        group_id: params[:group_id],
        artifact_id: params[:artifact_id],
        version: params[:version]
      }
    end
end
