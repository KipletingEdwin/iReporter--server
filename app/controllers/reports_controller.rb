class ReportsController < ApplicationController
    before_action :set_report, only: [:show, :update, :destroy]
  
    # GET /reports
    def index
      reports = Report.all
      render json: reports
    end
  
    # GET /reports/:id
    def show
      render json: @report
    end
  
    # POST /reports
    def create
      report = @current_user.reports.build(report_params)
      if report.save
        render json: report, status: :created
      else
        render json: { errors: report.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PUT /reports/:id
    def update
      if @report.update(report_params)
        render json: @report
      else
        render json: { errors: @report.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /reports/:id
    def destroy
      @report.destroy
      render json: { message: "Report deleted" }
    end
  
    private
  
    def set_report
      @report = Report.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Report not found" }, status: :not_found
    end
  
    def report_params
      params.permit(:title, :description, :location, :status)
    end
  end
  