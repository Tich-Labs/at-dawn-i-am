class Admin::EntriesController < ApplicationController
  before_action :authenticate_admin!, unless: -> { Rails.env.test? }
  before_action :set_entry, only: [ :show, :edit, :update, :destroy ]

  def index
    @entries = Entry.order(date: :desc)
  end

  def show
    @entry = Entry.find(params[:id])
    redirect_to edit_admin_entry_path(@entry)
  end

  def new
    @entry = Entry.new
  end

  def edit
  end

  def update
    @entry = Entry.find(params[:id])
    if @entry.update(entry_params)
      redirect_to admin_entries_path(highlighted_entry: @entry.id), notice: "Entry was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      redirect_to admin_entries_path(highlighted_entry: @entry.id), notice: "Entry was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @entry.destroy
    redirect_to admin_entries_path, notice: "Entry was successfully destroyed."
  end

  def update_status
    @entry = Entry.find(params[:id])
    new_status = params[:status]

    if %w[published draft hidden].include?(new_status)
      @entry.update!(status: new_status)

      case new_status
      when "published"
        flash[:notice] = "Entry published successfully! Now visible to public."
      when "draft"
        flash[:notice] = "Entry saved as draft. Hidden from public view."
      when "hidden"
        flash[:notice] = "Entry hidden successfully! No longer visible to public."
      end
    else
      flash[:alert] = "Invalid status"
    end

    redirect_to admin_entries_path(highlighted_entry: @entry.id)
  end

  private

  def set_entry
    @entry = Entry.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(:date, :body, :image, :status)
  end

  helper_method :current_admin_user
  def current_admin_user
    @current_admin_user ||= AdminUser.find_by(id: session[:admin_user_id]) if session[:admin_user_id]
  end

  helper_method :authenticate_admin!
  def authenticate_admin!
    redirect_to admin_login_path unless current_admin_user
  end
end
