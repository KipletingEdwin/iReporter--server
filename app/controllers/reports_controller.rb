class ReportsController < ApplicationController
    before_action :set_report, only: [:show, :update, :destroy]
  

    def index
      if @current_user.admin?
        reports = Report.all 
      else
        reports = @current_user.reports
      end
      render json: reports, include: :user
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
      report = Report.find(params[:id])

      unless @current_user.admin? || report.user_id == @current_user.id
        return render json: { error: "Unauthorized" }, status: :unauthorized
      end

      if report.update(report_params)
        render json: report
      else
        render json: { errors: report.errors.full_messages }, status: :unprocessable_entity
      end
    end

  
    # DELETE /reports/:id
    def destroy
      report = Report.find(params[:id])
    
      unless @current_user.admin? || report.user_id == @current_user.id
        return render json: { error: "Unauthorized" }, status: :unauthorized
      end
    
      report.destroy
      head :no_content
    end    
  
    private
  
    def set_report
      @report = Report.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Report not found" }, status: :not_found
    end 
  
    def report_params
      params.require(:report).permit(:title, :description, :location, :status, :image)
    end
  end
  